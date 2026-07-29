import 'package:final_burma_bus/views/route_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../data/bus_data.dart'; // Import your busConnections list
import '../router.dart';
import 'bottomBar.dart';
import 'warning_screen.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  String? selectedStart;
  String? selectedEnd;

  // List of all unique bus stops
  late List<String> allStops;

  // Filtered lists for search functionality
  List<String> filteredStartStops = [];
  List<String> filteredEndStops = [];

  // Controllers for search inputs
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allStops = _getAllBusStops();
  }

  // Extract all unique bus stops from the busConnections data
  List<String> _getAllBusStops() {
    final stopsSet = <String>{};
    for (var connection in busConnections) {
      stopsSet.addAll(connection.stops);
    }
    return stopsSet.toList()..sort(); // Sort stops alphabetically
  }

  /// Swaps the starting and destination points
  void swapLocations() {
    setState(() {
      String? temp = selectedStart;
      selectedStart = selectedEnd;
      selectedEnd = temp;

      // Update text controllers
      startController.text = selectedStart ?? '';
      endController.text = selectedEnd ?? '';

      // Automatically trigger route navigation after swapping
      findRoute(context);
    });
  }

  /// Automatically navigates to the appropriate screen once both points are selected
  void findRoute(BuildContext context) {
    if (selectedStart != null && selectedEnd != null) {
      if (selectedStart == selectedEnd) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WarningScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DirectionScreen(start: selectedStart!, end: selectedEnd!),
          ),
        );
      }
    }
  }

  /// Builds the search input fields for selecting bus stops
  Widget buildSearchField({
    required String hintText,
    required TextEditingController controller,
    required Function(String) onTextChanged,
    required List<String> filteredStops,
    required Function(String) onStopSelected,
    bool isDestinationField = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(Icons.search, color: Colors.yellow[700]),
            suffixIcon: isDestinationField
                ? IconButton(
              icon: Icon(Icons.swap_vert, color: Colors.yellow[700]),
              onPressed: swapLocations,
              tooltip: "Swap locations",
            )
                : null,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            onTextChanged(value);
          },
        ),
        const SizedBox(height: 8),
        if (filteredStops.isNotEmpty)
          Container(
            height: MediaQuery.of(context).size.height * 0.4, // Limit dropdown height
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: filteredStops.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredStops[index],
                    style: const TextStyle(color: Colors.black87),
                  ),
                  onTap: () {
                    onStopSelected(filteredStops[index]);
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            router.go('/home'); // Return to the previous screen
          },
        ),
      ),
      body: Stack(
        children: [
          // Full-screen map
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(16.774617706655356, 96.1586805927285), // Initial map center
              initialZoom: 18, // Initial zoom level
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              const MarkerLayer(markers: [
                Marker(
                  point: LatLng(16.774617706655356, 96.1586805927285),
                  child: Icon(
                    Icons.location_on_sharp,
                    color: Colors.redAccent,
                    size: 50,
                  ),
                ),
              ]),
            ],
          ),
          // Search bars overlaying the map
          Positioned(
            top: 20, // Position from the top of the screen
            left: 16, // Align to the left with padding
            right: 16, // Align to the right with padding
            child: Column(
              children: [
                // Starting Location Search Field
                buildSearchField(
                  hintText: "Enter Starting Location",
                  controller: startController,
                  onTextChanged: (value) {
                    setState(() {
                      filteredStartStops = allStops
                          .where((stop) => stop.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  filteredStops: filteredStartStops,
                  onStopSelected: (stop) {
                    setState(() {
                      selectedStart = stop;
                      startController.text = stop;
                      filteredStartStops = [];
                      findRoute(context);
                    });
                  },
                ),
                const SizedBox(height: 10),
                // Destination Search Field with Swap Button
                buildSearchField(
                  hintText: "Enter Destination",
                  controller: endController,
                  onTextChanged: (value) {
                    setState(() {
                      filteredEndStops = allStops
                          .where((stop) => stop.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  filteredStops: filteredEndStops,
                  onStopSelected: (stop) {
                    setState(() {
                      selectedEnd = stop;
                      endController.text = stop;
                      filteredEndStops = [];
                      findRoute(context);
                    });
                  },
                  isDestinationField: true, // Enable swap button for this field
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}