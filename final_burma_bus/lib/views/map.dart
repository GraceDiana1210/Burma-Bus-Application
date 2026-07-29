import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_burma_bus/views/bottomBar.dart';

class MapScreen extends StatefulWidget {
  final List<ItemData> items = const [
    ItemData(
      number: "64",
      numberColor: Colors.red,
      title: "(မေစ်စီ) ကိုကလေးရွာ - တအိုကီ",
      buttonColor: Colors.green,
      buttonText: "ရုံးမှတ်",
    ),
    ItemData(
      number: "116",
      numberColor: Colors.blue,
      title: "ဆူးလေ - တောင်ကြီး",
      buttonColor: Colors.green,
      buttonText: "ရုံးမှတ်",
    ),
    ItemData(
      number: "35",
      numberColor: Colors.blue,
      title: "မော်တော - တောင်ကြီး",
      buttonColor: Colors.orange,
      buttonText: "လုပ်ဆောင်",
    ),
  ];

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController controller = MapController();
  LatLng? currentLocation; // User's current location
  List<Map<String, dynamic>> driverLocations = []; // Driver locations
  StreamSubscription? locationSubscription;

  final TextEditingController latController = TextEditingController();
  final TextEditingController lngController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation(); // Fetch initial current location
    _startRealTimeLocationUpdates();
    _listenToDriverLocations(); // Listen to Firestore updates for drivers
  }

  /// Real-time listener for driver locations from Firestore
  void _listenToDriverLocations() {
    locationSubscription = FirebaseFirestore.instance
        .collection('driver_locations')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        driverLocations = snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            'name': data['name'],
            'latitude': data['latitude'],
            'longitude': data['longitude'],
            'email': data['email'],
            'routeId': data['routeId'],
          };
        }).toList();
      });
    });
  }

  /// Stop listening to Firestore updates
  @override
  void dispose() {
    locationSubscription?.cancel(); // Cancel the Firestore subscription
    super.dispose();
  }

  /// Fetch current device location
  Future<void> _fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        controller.move(currentLocation!, 15.0);
      });
    } catch (e) {
      print("Error fetching current location: $e");
    }
  }

  /// Start real-time location tracking for the user
  void _startRealTimeLocationUpdates() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });
      _updateLocationToFirestore(position.latitude, position.longitude);
    });
  }

  /// Update Firestore with the current location
  Future<void> _updateLocationToFirestore(double latitude, double longitude) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'location': {
          'latitude': latitude,
          'longitude': longitude,
          'timestamp': DateTime.now(),
        },
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating Firestore location: $e");
    }
  }

  void _adjustLocationManually() {
    final double? latitude = double.tryParse(latController.text);
    final double? longitude = double.tryParse(lngController.text);

    if (latitude != null && longitude != null) {
      setState(() {
        currentLocation = LatLng(latitude, longitude);
        controller.move(currentLocation!, 15.0);
      });
      _updateLocationToFirestore(latitude, longitude);
    } else {
      _showSnackBar("Invalid latitude or longitude. Please check the input.");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () => context.go('/home'),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            const SizedBox(width: 10),
            const Text("Real-Time Bus Tracking"),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Map Section
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: FlutterMap(
                mapController: controller,
                options: MapOptions(
                  center: currentLocation ?? const LatLng(0, 0),
                  zoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      // Driver markers
                      ...driverLocations.map((driver) {
                        if (driver['latitude'] != null && driver['longitude'] != null) {
                          return Marker(
                            point: LatLng(driver['latitude'], driver['longitude']),
                            width: 80,
                            height: 80,
                            rotate: true,
                            child: Tooltip(
                              message: "${driver['name']} (Route: ${driver['routeId']})",
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                                size: 50,
                              ),
                            ),
                          );
                        }
                        return null;
                      }).whereType<Marker>(),

                      // Current location marker
                      if (currentLocation != null)
                        Marker(
                          point: currentLocation!,
                          width: 40,
                          height: 40,
                          rotate: true,
                          child: const Icon(
                            Icons.location_on_sharp,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: latController,
                          decoration: const InputDecoration(
                            labelText: 'Latitude',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: lngController,
                          decoration: const InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _fetchCurrentLocation,
                        icon: const Icon(Icons.my_location),
                        label: const Text("Get Current Location"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: _adjustLocationManually,
                        icon: const Icon(Icons.edit_location),
                        label: const Text("Adjust Location"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bus Routes List
            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return Card(
                    child: ListTile(
                      leading: Text(
                        item.number,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: item.numberColor,
                        ),
                      ),
                      title: Text(item.title),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: item.buttonColor,
                        ),
                        child: Text(item.buttonText),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

class ItemData {
  final String number;
  final Color numberColor;
  final String title;
  final Color buttonColor;
  final String buttonText;

  const ItemData({
    required this.number,
    required this.numberColor,
    required this.title,
    required this.buttonColor,
    required this.buttonText,
  });
}
