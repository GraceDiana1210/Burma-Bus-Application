import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/get_started_bg.png"), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Enlarged Logo Image without Circle
            Positioned(
              top: 80, // Space from the top
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  "images/logo_with_border.png", // Logo image
                  width: 250, // Make the image bigger
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Centered Column for Text and Button
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // Center alignment
                children: [
                  const SizedBox(height: 250), // Space for the logo
                  const Text(
                    "YBS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "PuPu", // Use the custom font
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "စီးရတာ စိတ်ညစ်နေပြီလား?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "PuPu", // Use the custom font
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "မပူနဲ့ ...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "PuPu", // Use the custom font
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "BURMA BUS ရှိတယ်",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "PuPu", // Use the custom font
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Get Started Button
                  ElevatedButton(
                    onPressed: () {
                      context.go('/welcome');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button color
                      foregroundColor: Colors.orange, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Rounded button
                      ),
                    ),
                    child: const Text(
                      "GET STARTED",
                      style: TextStyle(
                        fontFamily: "PuPu", // Use the custom font
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Footer text or terms
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Terms and conditions",
                  style: TextStyle(
                    fontFamily: "PuPu", // Use the custom font
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}