import 'package:final_burma_bus/driver/driverScreen.dart';
import 'package:final_burma_bus/views/aboutUs.dart';
import 'package:final_burma_bus/views/editProfile.dart';
import 'package:final_burma_bus/views/home.dart';
import 'package:final_burma_bus/views/map.dart';
import 'package:final_burma_bus/views/noti.dart';
import 'package:final_burma_bus/views/paymentOptionScreen.dart';
import 'package:final_burma_bus/views/reportForm.dart';
import 'package:final_burma_bus/views/route.dart';
import 'package:final_burma_bus/views/time.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_burma_bus/views/StartUp.dart';
import 'package:final_burma_bus/views/GetStarted.dart';
import 'package:final_burma_bus/views/Welcome.dart';

import 'package:final_burma_bus/views/SignUp.dart';
import 'package:final_burma_bus/views/Login.dart';
import 'package:final_burma_bus/views/Profile.dart';
import 'package:final_burma_bus/views/payment.dart';
import 'package:final_burma_bus/views/adminScreen.dart';
import 'chatGPT/newChat.dart';

import 'views/forgot_pass.dart';


// Fetch user role from Firestore
Future<String?> fetchRole(String uid) async {
  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return doc.data()?['role'];
}

final GoRouter router = GoRouter(
  initialLocation: '/', // Start with StartUp Screen
  routes: [
    GoRoute(
      path: '/', // StartUp Screen
      builder: (context, state) => const StartUp(),
    ),
    GoRoute(
      path: '/get-started', // GetStarted Screen
      builder: (context, state) => const GetStarted(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const Welcome(),
    ),
    GoRoute(
      path: '/home', // Home Screen
      builder: (context, state) => Home(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUp(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(path: '/forgetpassword',
      builder: (context, state) => const ForgotPassword(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const Profile(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => PaymentScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state)  => const MapScreen(),
    ),
    GoRoute(
      path: '/route',
      builder: (context, state) => const RouteScreen(),
    ),
    GoRoute(
      path: '/aboutus',
      builder: (context, state) => const AboutUsScreen(),
    ),
    GoRoute(
      path: '/editprofile',
      builder: (context, state) => const EditProfile(),
    ),
    GoRoute(path: '/noti',
        builder: (context, state) =>  const NotificationScreen()
    ),
    GoRoute(path: '/report',
        builder: (context, state) =>  const ReportForm()),
    GoRoute(path: '/driver',
        builder: (context, state) =>  const DriverScreen()),

    GoRoute(path: '/paymentoptionscreen',
      builder: (context, state) => const PaymentOptionsScreen(),),

    GoRoute(path: '/newchatscreen',
      builder: (context, state) => NewChatScreen(),),
    GoRoute(path: '/chat',

        builder:  (context, state) => NewChatScreen()),

    GoRoute (path: '/time',
        builder:  (context, state) => const BusSearchPage()),

    GoRoute(
      path: '/admin',
      redirect: (context, state) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return '/login'; // If user is not authenticated, go to login
        final role = await fetchRole(user.uid);
        return (role == 'admin') ? null : '/home'; // Only allow admin
      },
      builder: (context, state) => const AdminScreen(),
    ),
  ],
);