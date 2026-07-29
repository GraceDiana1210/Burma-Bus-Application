// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyAyPJk-49pnjGKotZ-OrQ9p701gEMJFqII',
      appId: '1:542519430417:android:231478dcd3bc84179350b0',
      messagingSenderId: '542519430417',
      projectId: 'burmabus-b9685',
      storageBucket: 'burmabus-b9685.firebasestorage.ap',
      authDomain: 'YOUR_AUTH_DOMAIN',
      measurementId: 'YOUR_MEASUREMENT_ID', // Optional for some projects
    );
  }
}