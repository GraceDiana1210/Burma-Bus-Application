import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

/// Function to define assigned routes
List<Map<String, dynamic>> getAssignedRoutes() {
  return [
    {
      "routeId": "21",
      "name": "Route 21",
      "polyline": [
        {"latitude": 16.9472, "longitude": 96.0150},
        {"latitude": 16.7980, "longitude": 96.1495},
        {"latitude": 16.8998, "longitude": 96.1270},
        {"latitude": 16.8400, "longitude": 96.1730},
        {"latitude": 16.8050, "longitude": 96.2110},
      ],
    },
    {
      "routeId": "35",
      "name": "Route 35",
      "polyline": [
        {"latitude": 16.8450, "longitude": 96.1300},
        {"latitude": 16.8600, "longitude": 96.1400},
        {"latitude": 16.8700, "longitude": 96.1500},
        {"latitude": 16.8800, "longitude": 96.1600},
        {"latitude": 16.8900, "longitude": 96.1700},
      ],
    },
  ];
}

/// Function to create the AssignedRoute collection in Firestore
Future<void> createAssignedRoutesInFirestore() async {
  try {
    List<Map<String, dynamic>> routes = getAssignedRoutes();
    final routesCollection = FirebaseFirestore.instance.collection('AssignedRoute');

    for (var route in routes) {
      await routesCollection.doc(route['routeId']).set({
        "name": route['name'],
        "polyline": route['polyline'],
      });
    }

    print("AssignedRoute collection successfully created!");
  } catch (e) {
    print("Error creating AssignedRoute collection: $e");
  }
}

/// Initialize Firebase and create routes
Future<void> initializeAndCreateRoutes() async {
  await Firebase.initializeApp();
  await createAssignedRoutesInFirestore();
}
