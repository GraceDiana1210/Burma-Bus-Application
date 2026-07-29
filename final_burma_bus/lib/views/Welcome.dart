import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background Image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/welcome_bg.png"), // Your background image
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Add space to lower down the content
              const SizedBox(height: 330), // Adjust this value to move everything down

              // Title: "BURMA BUS"
              Text(
                "BURMA BUS",
                style: TextStyle(
                  fontFamily: "PuPu", // Custom font
                  fontSize: 32,
                  color: Colors.grey[800], // Dark grey color
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 10),

              // Subtitle
              const Text(
                "လမ်းကြောင်းရှာမယ် ၊ အချိန်ကြည့်မယ် ၊\nကားခပေးမယ်",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "PuPu", // Custom font
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5, // Line height for spacing
                ),
              ),

              const SizedBox(height: 40),

              // Sign In Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text Above Sign In Button
                  const Text(
                    "Account ရှိပြီးသားလား ? ဒီကိုသွား",
                    style: TextStyle(
                      fontFamily: "PuPu", // Custom font
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Sign In Button
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFDF3E7), // Light beige background
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily: "PuPu",
                          fontSize: 16,
                          color: Colors.blue, // Blue text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Sign Up Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text Above Sign Up Button
                  const Text(
                    "ခုမှစသုံးတာလား ? ဒီကိုသွား",
                    style: TextStyle(
                      fontFamily: "PuPu", // Custom font
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Sign Up Button
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/signup');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFDF3E7), // Light beige background
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: "PuPu",
                          fontSize: 16,
                          color: Colors.blue, // Blue text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}