import 'package:final_burma_bus/views/bottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import '../paymentMethod/burmaCard.dart';
import '../router.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  String? scannedUID;
  bool isScanning = false;
  bool isEmulating = false;
  static const platform = MethodChannel('real_nfc/hce');

  int selectedIndex = 1; // Default to "YBS Card"
  String cardHolder = "";
  String cardNumber = "";
  String balance = "";
  String userId = ""; // Dynamic user ID

  @override
  void initState() {
    super.initState();
    _fetchFirestoreData(); // Fetch Firestore data on initialization
    _loadStoredUID();
  }

  Future<void> _loadStoredUID() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      scannedUID = prefs.getString('uid');
    });
  }

  Future<void> _saveUID(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    _loadStoredUID();
  }

  Future<void> _startNFCScan() async {
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (!isAvailable) {
        _showDialog("Error", "NFC is not available on this device.");
        return;
      }

      setState(() {
        isScanning = true;
        print("📡 NFC scanning started...");
      });

      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          print("✅ NFC Tag detected!");

          try {
            Uint8List? identifier = tag.data["mifare"]["id"];
            if (identifier == null) {
              throw Exception("Could not retrieve NFC UID");
            }

            String uid = identifier.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(':');
            print("🎯 UID Found: $uid");

            await _saveUID(uid);
            _showDialog("Scan Successful", "UID: $uid");
          } catch (e) {
            print("❌ Error reading tag: ${e.toString()}");
            _showDialog("Error", "Failed to read tag: ${e.toString()}");
          } finally {
            setState(() => isScanning = false);
          }
        },
        pollingOptions: {NfcPollingOption.iso14443},
      );
    } catch (e) {
      print("❌ Error: ${e.toString()}");
      _showDialog("Error", e.toString());
      setState(() => isScanning = false);
    }
  }

  Future<void> _deleteUID() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    setState(() {
      scannedUID = null;
    });
  }

  Future<void> _startHCE() async {
    if (scannedUID == null) {
      _showDialog("Error", "Scan a card first!");
      return;
    }

    try {
      await platform.invokeMethod('startHCE', {'uid': scannedUID});
      setState(() => isEmulating = true);
      _showDialog("HCE Started", "Emulating UID: $scannedUID");
    } on PlatformException catch (e) {
      _showDialog("HCE Error", e.message ?? 'Unknown error');
    }
  }


  Future<void> _stopHCE() async {
    try {
      await platform.invokeMethod('stopHCE');
      setState(() => isEmulating = false);
    } on PlatformException catch (e) {
      _showDialog("HCE Error", e.message ?? 'Unknown error');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchFirestoreData() async {
    try {
      // Get the currently logged-in user's ID
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User is not logged in");
      }
      userId = user.uid; // Dynamic user ID

      // Fetch user data from Firestore
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data();
        setState(() {
          cardHolder = data?['name'] ?? "Unknown";
          cardNumber = data?['cardId'] ?? "";
          balance = data?['balance']?.toString() ?? "0";
        });

        // Check if cardNumber is missing, prompt the user to enter it
        if (cardNumber.isEmpty) {
          _showCardIdInputDialog();
        }
      } else {
        print("No document found for user ID: $userId");
      }
    } catch (e) {
      print("Error fetching Firestore data: $e");
    }
  }

  void _showCardIdInputDialog() {
    TextEditingController cardIdController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Enter Card ID",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: cardIdController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter your card ID",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without saving
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                String enteredCardId = cardIdController.text.trim();

                if (enteredCardId.isNotEmpty) {
                  // Save the Card ID to Firestore
                  await _saveCardIdToFirestore(enteredCardId);
                  setState(() {
                    cardNumber = enteredCardId; // Update the UI
                  });
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Show an error message if the input is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Card ID cannot be empty")),
                  );
                }
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveCardIdToFirestore(String cardId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'cardId': cardId, // Update the Card ID
        'balance': 0,    // Reset the payment balance to 0
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Card ID saved and balance reset to 0 successfully")),
      );
    } catch (e) {
      print("Error updating Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update Card ID and balance")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.go('/home');
                },
                icon: Icon(Icons.arrow_back_rounded),
              ),
              SizedBox(width: 10),
              Text("Payment"),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              _buildToggleSwitch(),
              SizedBox(height: 20),
              _buildContent(),
              SizedBox(height: 20),
              _buildBalanceSection(),
              SizedBox(),
              _buildCurrentInfo('ငွေသွင်းမှုများ'),


            ],
          ),
        ),
        bottomNavigationBar: const
        CustomBottomNavBar(currentIndex: 2),
      ),
    );
  }

  Widget _buildToggleSwitch() {
    return Center(
      child: ToggleSwitch(
        minWidth: MediaQuery.of(context).size.width * 0.8,
        minHeight: 40.0,
        cornerRadius: 10.0,
        activeBgColors: const [
          [Colors.yellow],
          [Colors.yellow],
        ],
        activeFgColor: Colors.black,
        inactiveBgColor: Colors.grey.shade300,
        inactiveFgColor: Colors.black,
        totalSwitches: 2,
        labels: const ['QR Code', 'YBS Card'],
        radiusStyle: true,
        initialLabelIndex: selectedIndex, // Set to YBS Card initially
        onToggle: (index) {
          setState(() {
            selectedIndex = index!;
            if (selectedIndex == 0) {
              _showNfcRequiredPopup(); // Show NFC popup when switching to QR Code
            }
          });
        },
      ),
    );
  }

  Widget _buildContent() {
    return selectedIndex == 0
        ? Center(
      child: Text(
        "QR Code Selected",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    )
        : BurmaCard(
      backgroundImage: 'images/BurmaCard.png',
      cardExpiration: "08/2027", // Static expiration date
      cardHolder: cardHolder,
      cardNumber: cardNumber,
    );
  }

  Widget _buildBalanceSection() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[
          scannedUID != null
              ? Card(
            child: Center(
              child: Column(
                children: [
                  QrImageView(
                    data: scannedUID!,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  SizedBox(height: 10),
                  _buildInfoContainer("Card UID - $scannedUID"),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: Icon(isEmulating ? Icons.stop : Icons.play_arrow),
                    label: Text(isEmulating ? "Stop NFC" : "Pay with NFC"),
                    onPressed: isEmulating ? _stopHCE : _startHCE,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEmulating ? Colors.red : Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text("Delete UID"),
                    onPressed: _deleteUID,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                  ),
                ],
              ),
            ),
          )
              : Column(
            children: [
              _buildInfoContainer("လက်ကျန်ငွေ - ${balance ?? '0'} ကျပ်"),
              SizedBox(height: 10),
              _buildInfoContainer("Card UID: ${cardNumber ?? 'N/A'}"),
              SizedBox(height: 10),
              _buildRechargeButton(),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildCurrentInfo(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // Title Text
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0 ),
          child:  Text(
            text,
            textAlign: TextAlign.center,
            // Use the passed text parameter here
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
          ),
        ),

        SizedBox(height: 8),
        // List of Transactions
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2, // Number of items
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    '35', // Example route number
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text('အချိန်: ၁၀:၃၀ နာရီ'), // Example time
                trailing: Text(
                  '200 ကျပ်', // Example price
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }



  Widget _buildInfoContainer(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildRechargeButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: () {
          router.go('/paymentoptionscreen');
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.yellow,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        icon: Icon(
          Icons.credit_card,
          color: Colors.black,
        ),
        label: Text(
          "ငွေဖြည့်မယ်",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _showNfcRequiredPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "NFC Required",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/nfc_required.png', // Path to your image
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Text(
                isScanning ? "Please ensure NFC is enabled and hold your card near the device to proceed." : "",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
                setState(() {
                  selectedIndex = 1; // Navigate back to YBS Card view
                });
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _startNFCScan();
              },
              child: Text(
                isScanning ?
                "Scanning" : "Start Scan",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }


}
