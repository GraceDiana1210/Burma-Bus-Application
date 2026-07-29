import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'router.dart'; // Import router configuration
import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // // Prevent duplicate Firebase initialization
  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("🔥 Firebase already initialized: $e");
  }

  await requestNotificationPermission(); // Call the function here
  runApp(const MyApp());
}

Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router, // Connect the go_router configuration
      debugShowCheckedModeBanner: false,
    );
  }
}