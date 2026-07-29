import 'package:flutter/material.dart';
import '../services/auth_service.dart'; // Import your AuthService
import 'package:go_router/go_router.dart';

import '../router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  // Controllers for email and password fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Password visibility toggle
  bool _isPasswordVisible = false;

  // Firebase AuthService instance
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login.png"), // Background image
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 250),

              // Title: BURMA BUS
              const Text(
                "BURMA BUS",
                style: TextStyle(
                  fontFamily: "PuPu",
                  fontSize: 48,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Subtitle: Sign In ဝင်မယ်
              const Text(
                "Sign In ဝင်မယ်",
                style: TextStyle(
                  fontFamily: "PuPu",
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Form for validation and logic
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email Input Field
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        controller: emailController,
                        maxLength: 20,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          counterText: '',
                          labelText: 'Email(umya21@gmail.com)',
                          labelStyle: const TextStyle(fontFamily: "PuPu"),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                        style: const TextStyle(fontFamily: "PuPu"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Password Input Field
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        maxLength: 20,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          counterText: '',
                          labelText: 'Password',
                          labelStyle: const TextStyle(fontFamily: "PuPu"),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(fontFamily: "PuPu"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),

                    // Forget Password Hypertext
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              print("Forget password clicked");
                            },
                            child: const Text(
                              "Forget password?",
                              style: TextStyle(
                                fontFamily: "PuPu",
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sign In Button with Firebase Logic
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFFDF3E7),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();

                          // Call AuthService for login
                          String? role = await _authService.login(
                            email: email,
                            password: password,
                          );

                          if (role == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid email or password!'),
                              ),
                            );
                          } else if (role == 'admin') {
                            // Navigate to Admin Screen
                            context.go('/admin');
                          }else if( role == 'Driver' ){
                            router.go('/driver');
                          }
                          else {
                            // Navigate to Home Screen
                            context.go('/home');
                          }
                        }
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily: "PuPu",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Sign Up Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                        backgroundColor: Colors.white,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to Sign Up Screen
                        context.go('/signup');
                      },
                      child: const Text(
                        "ခုမှ စသုံးတာလား sign up ကိုသွား",
                        style: TextStyle(
                          fontFamily: "PuPu",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}