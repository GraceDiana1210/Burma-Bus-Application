import 'package:final_burma_bus/router.dart';
import 'package:final_burma_bus/views/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:final_burma_bus/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const ProfileApp());
}

// Root of the app
class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BURMA BUS Profile",
      home: Profile(),
    );
  }
}

// Profile Page
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final AuthService _authService = AuthService();

  // Fetch user data from Firestore
  Future<Map<String, dynamic>> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User not signed in");
      return {'name': 'User', 'id': 'Unknown'};
    }

    try {
      // Fetch the user document from Firestore using UID
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid) // Use UID as the document ID
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() ?? {};
        data['id'] = user.uid; // Add UID as 'id' in the map
        return data;
      } else {
        print("User document does not exist");
        return {'name': 'User', 'id': user.uid};
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {'name': 'User', 'id': 'Unknown'};
    }
  }


  // Show Rating Input Dialog
  void _showRatingInputDialog(BuildContext context) {
    double localRatingScore = 3.0; // Temporary rating score for the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                "Rate BURMA BUS App",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Please select your rating:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: localRatingScore,
                    min: 1.0,
                    max: 5.0,
                    divisions: 4,
                    label: localRatingScore.toStringAsFixed(1),
                    activeColor: Colors.orange,
                    inactiveColor: Colors.grey.shade300,
                    onChanged: (value) {
                      setDialogState(() {
                        localRatingScore = value;
                      });
                    },
                  ),
                  Text(
                    "Selected Rating: ${localRatingScore.toStringAsFixed(1)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitRating(localRatingScore);
                    Navigator.pop(context); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text("Submit"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Submit Rating Logic
  void _submitRating(double ratingScore) {
    print("User Rating Submitted: $ratingScore");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Thank you for rating: ${ratingScore.toStringAsFixed(1)}",
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFFFFC84D),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECEF),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _getUserData(), // Fetch user data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || snapshot.data == null) {
              return const Center(
                child: Text(
                  "Error loading user data",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            }

            final userData = snapshot.data!;
            final userName = userData['name'] ?? 'User';
            final userId = userData['id'] ?? '0000';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Account Header Section
                Container(
                  color: const Color(0xFFFFC84D),
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("images/profile.jpg"),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userName, // Dynamic name
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "ID: $userId", // Dynamic ID
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                // Options Section
                Expanded(
                  child: ListView(
                    children: [
                      _buildOptionItem(
                        icon: Icons.person,
                        title: "Profile နဲ့ပတ်သက်ပြီး ပြင်မယ်",
                        onTap: () {
                          router.go('/editprofile');
                        },
                      ),
                      _buildOptionItem(
                        icon: Icons.language,
                        title: "ဘာသာစကား ပြောင်း",
                        onTap: () {

                        },
                      ),
                      _buildOptionItem(
                        icon: Icons.star_rate,
                        title: "BURMA BUS app ကို rating ပေးမယ်",
                        onTap: () {
                          _showRatingInputDialog(context);
                        },
                      ),
                      _buildOptionItem(
                        icon: Icons.logout,
                        title: "Log out လုပ်မယ်",
                        onTap: () async {
                          await _authService.signOut();
                          router.go('/login');
                        },
                      ),
                      _buildOptionItem(
                        icon: Icons.info_outline,
                        title: "BURMA BUS အကြောင်း",
                        onTap: () {
                          router.go('/aboutus');
                        },
                      ),
                      _buildOptionItem(
                        icon: Icons.support,
                        title: "တိုင်ကြားမည်",
                        onTap: () {
                          router.go('/report');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  // Build an option item
  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black45),
      ),
    );
  }
}