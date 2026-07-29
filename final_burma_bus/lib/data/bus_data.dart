class BusConnection {
  final List<String> stops; // List of stops covered by this connection
  final double distance; // Total distance in kilometers
  final String busNumber;

  BusConnection(this.stops, this.distance, this.busNumber);

  // Calculate travel time based on average bus speed (40 km/h)
  double get travelTime => distance / 40 * 60;

  // Check if a connection covers a specific segment
  bool covers(String from, String to) {
    int fromIndex = stops.indexOf(from);
    int toIndex = stops.indexOf(to);
    return fromIndex != -1 && toIndex != -1 && fromIndex < toIndex;
  }

  // Get the distance and travel time for a specific segment
  Map<String, double> segmentDetails(String from, String to) {
    if (!covers(from, to)) return {"distance": 0, "travelTime": 0};
    int fromIndex = stops.indexOf(from);
    int toIndex = stops.indexOf(to);
    double segmentDistance =
        (distance / (stops.length - 1)) * (toIndex - fromIndex);
    return {
      "distance": segmentDistance,
      "travelTime": segmentDistance / 40 * 60,
    };
  }
}

// Expanded dataset with dynamically generated reverse routes
List<BusConnection> generateCompleteConnections(
    List<BusConnection> connections) {
  List<BusConnection> allConnections = [];
  for (var connection in connections) {
    // Add the original connection
    allConnections.add(connection);

    // Generate and add the reverse connection
    allConnections.add(BusConnection(
      List<String>.from(connection.stops.reversed),
      connection.distance,
      "${connection.busNumber} (Reverse)",
    ));
  }
  return allConnections;
}

// Expanded dataset with multi-segment connections
final List<BusConnection> busConnections = [
  BusConnection(
    [
      "စိုက်ပျိုးရေး",
      "မြေနီကုန်း",
      "စိန်ဂျွန်း",
      "ဗိုလ်ချုပ်ဈေး"
    ],
    10.0, // Total distance in km
    "105",
  ),
  // Bus 2 covers from Stop D to Stop G
  BusConnection(
    [
      "ဗိုလ်ချုပ်ဈေး",
      "ဆူးလေ",
      "မြို့တော်ခန်းမ",
      "ပန်းဆိုးတန်း"
    ],
    15.0, // Total distance in km
    "134",
  ),
  // Bus 3 covers from Stop G to Stop J
  BusConnection(
    [
      "ပန်းဆိုးတန်း",
      "လမ်း၅၀",
      "မာန်ပြေ",
      "ရှပ်ရှင်ရုံ"
    ],
    20.0, // Total distance in km
    "70",
  ),


];