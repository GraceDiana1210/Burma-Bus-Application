import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';  // FlutterMap for OpenStreetMap
import 'package:latlong2/latlong.dart';  // latlong2 for FlutterMap
import '../data/bus_data.dart'; // Your bus data import

class DirectionScreen extends StatelessWidget {
  final String start;
  final String end;

  const DirectionScreen({super.key, required this.start, required this.end});

  // Generate reverse routes dynamically for the dataset
  List<BusConnection> getCompleteConnections(List<BusConnection> connections) {
    List<BusConnection> completeConnections = List.from(connections);
    // Add reverse routes for each connection
    for (var connection in connections) {
      var reverseStops = List<String>.from(connection.stops.reversed);
      // Avoid duplicating reverse routes
      if (!completeConnections.any((c) => c.stops == reverseStops)) {
        completeConnections.add(
          BusConnection(
            reverseStops,
            connection.distance,
            "${connection.busNumber} (Reverse)",
          ),
        );
      }
    }
    return completeConnections;
  }

  // Finds multi-hop routes between start and end with up to maxDepth hops
  List<List<Map<String, dynamic>>> findValidRoutes(
      String start,
      String end,
      int maxDepth,
      List<BusConnection> connections,
      ) {
    List<List<Map<String, dynamic>>> allRoutes = [];
    List<Map<String, dynamic>> currentRoute = [];
    Map<String, int> visited = {};

    // Initialize visited map
    for (var connection in connections) {
      for (var stop in connection.stops) {
        visited[stop] = 0;
      }
    }

    // Helper function to get all buses at a stop
    List<BusConnection> getBusesAtStop(String stop) {
      return connections.where((connection) => connection.stops.contains(stop)).toList();
    }

    void dfs(String currentStop, int depth, String? currentBus, double currentDistance) {
      if (depth > maxDepth) return;
      if (currentStop == end) {
        allRoutes.add(List.from(currentRoute));
        return;
      }
      visited[currentStop] = 1;
      for (var connection in getBusesAtStop(currentStop)) {
        if (currentBus != null && currentBus != connection.busNumber) {
          // Add transfer point
          currentRoute.add({"transfer": "Switch to ${connection.busNumber} at $currentStop"});
        }
        for (int i = 0; i < connection.stops.length - 1; i++) {
          String from = connection.stops[i];
          String to = connection.stops[i + 1];
          if (from == currentStop && visited[to] == 0) {
            currentRoute.add({
              "from": from,
              "to": to,
              "busNumber": connection.busNumber,
              "distance": connection.distance,
            });
            dfs(to, depth + 1, connection.busNumber, currentDistance + connection.distance);
            currentRoute.removeLast();
          }
        }
        if (currentBus != null && currentBus != connection.busNumber) {
          // Remove transfer point if no route was found
          currentRoute.removeLast();
        }
      }
      visited[currentStop] = 0;
    }

    dfs(start, 0, null, 0);
    return allRoutes;
  }

  @override
  Widget build(BuildContext context) {
    // Generate complete dataset with reverse routes
    final completeConnections = getCompleteConnections(busConnections);

    // Find multi-hop routes
    final allRoutes = findValidRoutes(start, end, 10, completeConnections);

    // Simplify route summaries
    List<Map<String, dynamic>> multiHopRouteSummaries = allRoutes.map((route) {
      List<Map<String, String>> simplifiedRoute = [];
      String? currentBus;
      String? startStop;
      String? endStop;
      for (var step in route) {
        if (step.containsKey("transfer")) {
          // Add the previous bus leg's summary before the transfer
          if (currentBus != null && startStop != null && endStop != null) {
            simplifiedRoute.add({
              "type": "route",
              "description": "Take $currentBus from $startStop to $endStop",
            });
          }
          // Add the transfer point
          simplifiedRoute.add({
            "type": "transfer",
            "description": step["transfer"]!,
          });
          // Reset the bus leg tracking
          currentBus = null;
          startStop = null;
          endStop = null;
        } else {
          // Start a new bus leg if not already tracking
          if (currentBus == null) {
            currentBus = step["busNumber"];
            startStop = step["from"];
          }
          // Update the end stop of the current bus leg
          endStop = step["to"];
        }
      }

      // Add the final bus leg
      if (currentBus != null && startStop != null && endStop != null) {
        simplifiedRoute.add({
          "type": "route",
          "description": "Take $currentBus from $startStop to $endStop",
        });
      }

      return {"simplifiedRoute": simplifiedRoute};
    }).toList();

    // Initial camera position for the map
    const initialLatLng = LatLng(16.8409, 96.1735); // Replace with actual coordinates of the start

    return Scaffold(
      appBar: AppBar(
        title: Text('Routes to $end', style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow[700],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // OpenStreetMap widget using flutter_map
            SizedBox(
              height: 250,
              width: double.infinity,
              child: FlutterMap(
                options: MapOptions(
                    initialZoom: 15,
                    initialCenter: initialLatLng
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  // Add markers here if needed
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft, // Align the text to the left
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "စီးနိုင်သည့် လမ်းကြောင်းများ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Route summaries display
            if (multiHopRouteSummaries.isNotEmpty) ...[
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              ...multiHopRouteSummaries.map((route) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  color: Colors.yellow[600],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,  // Ensures the card fills available width
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...route["simplifiedRoute"].map<Widget>((step) {
                            return Text(
                              step["description"],
                              style: TextStyle(
                                fontWeight: step["type"] == "transfer" ? FontWeight.bold : FontWeight.normal,
                                color: step["type"] == "transfer" ? Colors.red : Colors.black,
                              ),
                            );
                          }).toList(),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
            if (multiHopRouteSummaries.isEmpty)
              Center(
                child: Text(
                  "No valid routes found.",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
          ],
        ),
      ),
    );
  }
}