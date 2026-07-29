import 'package:final_burma_bus/router.dart';
import 'package:final_burma_bus/views/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentOptionsScreen(),
    );
  }
}

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({super.key});

  final List<PaymentOption> paymentOptions = const [
    PaymentOption('images/kpay.png', 'Kpay', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ'),
    PaymentOption('images/aya.png', 'AYA Pay', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ'),
    PaymentOption('images/wavepay.png', 'Wave Pay', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ'),
    PaymentOption('images/cbPay.png', 'CB Pay', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ'),
    PaymentOption('images/A+.png', 'A+ Wallet', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ'),
  ];

  // Function to show payment dialog and update balance
  void _showPaymentPopup(BuildContext context, String title) {
    TextEditingController amountController = TextEditingController();
    TextEditingController noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            '$title ဖြင့်ငွေဖြည့်ရန် လုပ်ဆောင်ပါ',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "PuPu",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),

              // Amount Field
              _buildInputField(
                label: 'ဖြည့်မည့်ငွေပမာဏ',
                hint: '$title ပမာဏ',
                controller: amountController,
              ),
              const SizedBox(height: 10),

              // Note Field
              _buildInputField(
                label: 'မှတ်ချက်',
                hint: 'မှတ်ချက် ရိုက်ပါ',
                controller: noteController,
              ),
              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final String amount = amountController.text.trim();
                    if (amount.isNotEmpty) {
                      // Call Firestore to update the balance
                      await _updateBalance(double.parse(amount));

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$title ဖြင့် ငွေဖြည့်ခြင်း ပြီးမြောက်ပါသည်!'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ငွေပမာဏကို ဖြည့်ပါ')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'ငွေဖြည့်မည်',
                    style: TextStyle(fontFamily: "PuPu", fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Warning Text
              const Text(
                '*ဖြည့်သွင်းမည့်ငွေပမာဏကို သေချာစစ်ဆေးပါ!',
                style: TextStyle(
                  fontFamily: "PuPu",
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to update balance in Firestore for the dynamic user
  Future<void> _updateBalance(double amount) async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("User not logged in");
      }

      final String userId = currentUser.uid;
      final DocumentReference userDoc =
      FirebaseFirestore.instance.collection('users').doc(userId);

      // Get the current balance
      final DocumentSnapshot userSnapshot = await userDoc.get();
      if (userSnapshot.exists) {
        final currentBalance = userSnapshot['balance'] ?? 0.0;
        final newBalance = currentBalance + amount;

        // Update the balance
        await userDoc.update({'balance': newBalance});
      }
    } catch (e) {
      print("Error updating balance: $e");
    }
  }

  // Function to fetch current balance dynamically
  Widget _buildBalanceWidget() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Text(
        'No User Logged In',
        style: TextStyle(fontSize: 20, color: Colors.red, fontFamily: "PuPu"),
      );
    }

    final String userId = currentUser.uid;
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Text(
            'Error Loading Balance',
            style: TextStyle(fontSize: 20, color: Colors.red, fontFamily: "PuPu"),
          );
        }

        final balance = snapshot.data!['balance'] ?? 0.0;
        return Text(
          '$balance .00',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "PuPu",
          ),
        );
      },
    );
  }

  // Function to build input fields
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontFamily: "PuPu", fontSize: 14),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 14),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => router.go('/payment'),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.white, fontFamily: "PuPu"),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'လက်ကျန်ငွေ',
            style: TextStyle(fontSize: 20, fontFamily: "PuPu"),
          ),
          const SizedBox(height: 10),
          // Current Balance Widget
          _buildBalanceWidget(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: paymentOptions.length,
              itemBuilder: (context, index) {
                final option = paymentOptions[index];
                return GestureDetector(
                  onTap: () => _showPaymentPopup(context, option.title),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        // Payment Option Image
                        Image.asset(
                          option.imagePath,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: [
                            Text(
                              option.title,
                              style: const TextStyle(
                                fontFamily: 'PuPu',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              option.subtitle,
                              style: const TextStyle(
                                fontFamily: 'PuPu',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                        // Payment Option Title

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const
      CustomBottomNavBar(currentIndex: 2),
    );

  }
}
class PaymentOption {
  final String imagePath;
  final String title;
  final String subtitle;
  const PaymentOption(this.imagePath, this.title, this.subtitle, );
}