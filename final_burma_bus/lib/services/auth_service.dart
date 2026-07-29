import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';

class AuthService {

  // Firebase Authentication and Firestore instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Sign up a new user and save additional data in Firestore.
  Future<void> sendEmailVerificationLink() async {
    try{
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }


  Future<void> sendPasswordResetLink(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> signup({
    required BuildContext context, // Required for navigation
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      // Create a new user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Save additional user data (name and role) in Firestore
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': name.trim(),
          'email': email.trim(),
          'role': role,
          'createdAt': DateTime.now(),
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign up successful! Please log in.")),
        );

        // Navigate to the Login screen
        if (context.mounted) {
          // Use context.go to navigate to '/login'
          context.go('/login');
        }
      }

      return null; // Return null to indicate success
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      return e.message ?? 'An error occurred during sign-up.';
    } catch (e) {
      // Handle unexpected errors
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  /// Log in an existing user and fetch their role from Firestore.
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      // Authenticate the user with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Fetch additional user data (e.g., role) from Firestore
      if (userCredential.user != null) {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          return userDoc['role'] as String; // Return the user's role
        } else {
          return 'User data not found in Firestore.';
        }
      }
      return 'User authentication failed.';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occurred during login.';
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  /// Log out the current user.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // Navigate to the login screen or perform any post-sign-out action
      router.go('/login');
    } catch (e) {
      print("Error during sign-out: $e");
    }
  }

  /// Get the current user's details (optional utility method).
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}