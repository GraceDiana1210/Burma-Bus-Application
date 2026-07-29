import 'package:final_burma_bus/services/auth_service.dart';
import 'package:flutter/material.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = AuthService();
  final _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter emil to send you a password reset email"),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: "Enter Email",
              ),
              textInputAction:
              TextInputAction.done, // Specifies the action on the keyboard
            ),
            const SizedBox(
              height: 20,
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await _auth.sendPasswordResetLink(_email.text);
            //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //         content: Text(
            //             "An email for password reset has been sent to your email,")));
            //     router.go('/login');
            //   }, // Define your callback function here
            //
            //   child: Text("Send Email"), // Display text on the button
            // )
          ],
        ),
      ),
    );
  }
}