import 'package:final_burma_bus/router.dart';
import 'package:final_burma_bus/views/bottomBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MaterialApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final List<String> imageList = [
    'images/home_slider1.jpg',
    'images/home_slider2.jpg',
    'images/home_slider3.jpg',
  ];

   Home({super.key});

  //const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 80, // Increase width
        height: 80, // Increase height
        child: FloatingActionButton(
          onPressed: () {
            router.go('/NewChatScreen');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Larger Floating Action Button Pressed!')),
            );
          },
          backgroundColor: Colors.yellow, // Customize color
          shape: const CircleBorder(), // Ensure circular shape
          elevation: 10.0, // 3D effect
          child: Ink.image(
            image: const AssetImage('images/AI.png'), // Use the correct path
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: Colors.grey[100], // Light gray background
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 40),

            // Profile Section with Divider
            const ProfileSection(),

            const SizedBox(height: 16),

            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                  ),
                  items: imageList.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ရန်ကုန်လမ်းများအားလုံးအတွက်\nဘားမားဘက်စ်နဲ့ရှေ့ဆက်',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4.0,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            // Title Section
            const Center(
              child: Text(
                'ဘာလုပ်ချင်တာလဲ ?',
                style: TextStyle(
                  fontFamily: "PuPu",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ActionButtons(),
            ),

            const SizedBox(height: 16),

            // Map Section
            const MapPreview(),
            const SizedBox(height: 16),

            // Advertisement Section
            const Center(
              child: Text(
                'ကြော်ငြာဝင်ပါမည်',
                style: TextStyle(
                  fontFamily: "PuPu",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            const FooterAd(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

// Updated Profile Section with Divider


class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  // Fetch user data from Firestore
  Future<String> getUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('User not signed in');
      return 'User';
    }

    try {
      // Query Firestore to get the user's document
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Check if the document exists and contains the 'name' field
      if (userDoc.exists && userDoc.data() != null) {
        return userDoc.data()?['name'] ?? 'User';
      } else {
        print('No user document found');
        return 'User';
      }
    } catch (e) {
      print('Error fetching user name: $e');
      return 'User';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUserName(), // Fetch user name
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Error loading name',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          final userName = snapshot.data ?? 'User';

          return Column(
            children: [
              // Profile Row
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Action when the profile row is clicked
                    router.go('/profile');
                    // Example navigation
                    // router.go('/profile');
                  },
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.grey.withOpacity(0.2),
                  highlightColor: Colors.grey.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.person, color: Colors.black),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Dynamic User Name
                            Text(
                              'မင်္ဂလာပါ $userName',
                              style: const TextStyle(
                                fontFamily: "PuPu",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'YBS စီးနေတာလား? ဂရုစိုက်နော်',
                              style: TextStyle(
                                fontFamily: "PuPu",
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),

              // Line Separator
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5, // Thin line
                ),
              ),
            ],
          );
        }
      },
    );
  }
}



class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            router.go('/route');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                vertical: 18, horizontal: 20), // Add horizontal padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.place_outlined, color: Colors.black, size: 24),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'လမ်းကြောင်းရှာမယ်',
                  style: TextStyle(
                    fontFamily: "PuPu",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            router.go('/time');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                vertical: 18, horizontal: 20), // Add horizontal padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.directions_bus, color: Colors.black, size: 24),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Bus အချိန် ကြည့်မယ်',
                  style: TextStyle(
                    fontFamily: "PuPu",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ActionButton({super.key, 
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontFamily: "PuPu",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class MapPreview extends StatelessWidget {
  const MapPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'images/mapbg.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FooterAd extends StatelessWidget {
  const FooterAd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'images/foodpanda.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}