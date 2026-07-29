import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class StartUp extends StatefulWidget {
  const StartUp({super.key});

  @override
  StartUpState createState() => StartUpState();
}

class StartUpState extends State<StartUp> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a loading delay

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // If not logged in, go to Get Started
      context.go('/get-started');
    } else {
      // Fetch the user role from Firestore
      final roleDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final role = roleDoc.data()?['role'] as String?;

      if (role == 'admin') {
        context.go('/admin'); // Navigate to Admin Screen
      }else if( role == 'Driver'){
        context.go('/driver');
      } else {
        context.go('/home'); // Navigate to Home Screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9CE6E), // Background color
      body: Center(
        child: Image.asset(
          'images/logonobg.png', // Ensure the asset path is correct
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}