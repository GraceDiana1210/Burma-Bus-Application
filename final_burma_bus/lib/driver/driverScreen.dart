import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../views/home.dart';
import '../views/showBottomNoti.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  final ValueNotifier<LatLng> _busPosition =
      ValueNotifier(const LatLng(17.0995334, 96.2255428));
  final ValueNotifier<String> _currentStopName =
      ValueNotifier("Starting Point");
  final ValueNotifier<String> _nextStopName = ValueNotifier("Next Stop");
  final ValueNotifier<String> _distance = ValueNotifier("0");
  int _currentIndex = 0;
  late Timer _timer;
  LatLng get busLocation => _busPosition.value;
  Color _routeColor = Colors.blue;
  @override
  void initState() {
    super.initState();
    _initializeRoute();
    _startBusAnimation();
  }

  void _initializeRoute() {
    // Parse coordinates from GeoJSON
    final coordinates =
        (geoJsonData['features'][0]['geometry']['coordinates'] as List)
            .cast<List<dynamic>>();
    _routePoints =
        coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();

    final colorString = geoJsonData['features'][0]['properties']['color'];
    _routeColor = Color(int.parse(colorString.replaceFirst('#', '0xff')));
  }

  void _startBusAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_currentIndex < _routePoints.length - 1) {
        _currentIndex++;
        _busPosition.value = _routePoints[_currentIndex];
        _updateStopInfo();
        // Send location update to a function
        _sendBusLocation(_busPosition.value);
      } else {
        _timer.cancel(); // Stop animation when reaching the last point
      }
    });
  }

  void _sendBusLocation(LatLng location) {
    print("Bus is at: ${location.latitude}, ${location.longitude}");
    // TODO: Send this data to a database, Firestore, API, etc.
  }

  List<LatLng> _routePoints = [];
  Map<String, dynamic> get geoJsonData => {
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "id": "route/1",
            "properties": {
              "type": "BusService",
              "id": 1,
              "service_name": "1",
              "svc_type": "MAIN",
              "color": "#405CAA",
              "station": "ယုဇနဥယျာဉ်",
              "start": "ယုဇနဥယျာဉ်မြို့တော်",
              "end": "ဆူးလေ",
              "bus_stops":
                  "ယုဇနဥယျာဉ်မြို့တော်-ပဲခူးမြစ်လမ်း-ဧရာဝဏ်လမ်း-ကွေ့မ-ရတနာလမ်း-တိုင်းရင်းသားကျေးရွာ-သံလျင်တံတားချဉ်းကပ်လမ်း-သာကေတအဝိုင်း-ကျောက်တိုင်-မင်းနန္ဒာလမ်း-မဟာဗန္ဓုလတံတား-အနော်ရထာလမ်း-ဆူးလေ-မဟာဗန္ဓုလလမ်း -(၃၂) ဂိတ်-(၁၁) လမ်း-ပိတောက်ကွေ့-မုခ်ဦး (ယုဇနဥယျာဉ်)-မဝတရုံးရှေ့/အိုးအိမ်-မြနန္ဒာ-ရတနာလမ်း-သိမ်ကျောင်း-(၆၅) ရပ်ကွက်-ဆောက်လုပ်ရေး-အလိုတော်ပြည့်-သစ်ဆိတ်-အာဆီယံ--(၁၃) ဂိတ်-ဂိတ်ဝ-ခန်းမ-(၄၉) အစိမ်းဂိတ်-ကြယ်ငါးပွင့်-ဝေဇယန္တာ-(၅) ကွေ့-နယ်မြေရုံး-ဆီဆိုင်-မီးသွေးဆိုင်-ကျောင်းရှေ့-ရှုခင်းသာ-ဓမ္မာရုံ-(၃) ဂိတ်ဟောင်း-မာန်ပြေ-ရန်ပြေ-သင်္ဘောကျင်း-အိုးရှင်း-မဆလာစက်/ ဂန္ဓီ-လမ်း(၅၀)-(၄၆) လမ်း-ပန်းဆိုးတန်း-ဘားလမ်း-ဆူးလေပန်းခြံ-ဘိုကလေးဈေး-ဂန္ဓီ"
            },
            "geometry": {
              "type": "LineString",
              "coordinates": [
                [96.267102, 16.821695],
                [96.267658, 16.822455],
                [96.267998, 16.823452],
                [96.268384, 16.824315],
                [96.268535, 16.82567],
                [96.268964, 16.82678],
                [96.270616, 16.828833],
                [96.270852, 16.82986],
                [96.270265, 16.832381],
                [96.267589, 16.831726],
                [96.243801, 16.838244],
                [96.240764, 16.828604],
                [96.238169, 16.820221],
                [96.23762, 16.818355],
                [96.236598, 16.815297],
                [96.236293, 16.814424],
                [96.234164, 16.811804],
                [96.234486, 16.811136],
                [96.234799, 16.810647],
                [96.235185, 16.809394],
                [96.236172, 16.80886],
                [96.236172, 16.807638],
                [96.233629, 16.807165],
                [96.229145, 16.806508],
                [96.226806, 16.805316],
                [96.225583, 16.804803],
                [96.22513, 16.804632],
                [96.225109, 16.801705],
                [96.218459, 16.806983],
                [96.218037, 16.807305],
                [96.217608, 16.806997],
                [96.217231, 16.806636],
                [96.212779, 16.804453],
                [96.211694, 16.803909],
                [96.210452, 16.803666],
                [96.203988, 16.803798],
                [96.196822, 16.804074],
                [96.195603, 16.804465],
                [96.195569, 16.804141],
                [96.196358, 16.80304],
                [96.19669, 16.802269],
                [96.196888, 16.801448],
                [96.19692, 16.800384],
                [96.19674, 16.799173],
                [96.189075, 16.784058],
                [96.188778, 16.783015],
                [96.188586, 16.782269],
                [96.188105, 16.781989],
                [96.187487, 16.78184],
                [96.186363, 16.782409],
                [96.185847, 16.782516],
                [96.183097, 16.776644],
                [96.182461, 16.775264],
                [96.182054, 16.774799],
                [96.181314, 16.774275],
                [96.180297, 16.773631],
                [96.178106, 16.773689],
                [96.175365, 16.773792],
                [96.17536, 16.774249],
                [96.175447, 16.776338],
                [96.172728, 16.776406],
                [96.167218, 16.776599],
                [96.158838, 16.776893],
                [96.158834, 16.775051],
                [96.159009, 16.77485],
                [96.159176, 16.774739],
                [96.159267, 16.774548],
                [96.15929, 16.774341],
                [96.17527, 16.773793]
              ]
            }
          }
        ]
      };

  void _updateStopInfo() {
    final busStops =
        (geoJsonData['features'][0]['properties']['bus_stops'] as String)
            .split('-');
    final nextStopIndex = _currentIndex + 1;
    final isLastStop = nextStopIndex >= busStops.length;

    _currentStopName.value = _currentIndex < busStops.length
        ? busStops[_currentIndex].trim()
        : "End of Route";
    _nextStopName.value =
        isLastStop ? "End of Route" : busStops[nextStopIndex].trim();

    double distance = 0;
    if (!isLastStop && nextStopIndex < _routePoints.length) {
      final nextPoint = _routePoints[nextStopIndex];
      distance = const Distance().as(LengthUnit.Meter, _busPosition.value, nextPoint);
    }
    _distance.value = distance.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    // Parse coordinates from GeoJSON
    final coordinates =
        (geoJsonData['features'][0]['geometry']['coordinates'] as List)
            .cast<List<dynamic>>();

    // Convert to LatLng objects (swap coordinates)
    final routePoints =
        coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();

    // Parse route color

    // Parse bus stops
    final busStops =
        (geoJsonData['features'][0]['properties']['bus_stops'] as String)
            .split('-')
            .where((stop) => stop.isNotEmpty)
            .toList();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProfileSection(),

          // Map Section
          Expanded(
            flex: 10,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _routePoints.first,
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: _routeColor,
                      strokeWidth: 4,
                    ),
                  ],
                ),
                ValueListenableBuilder(
                    valueListenable: _busPosition,
                    builder: (context, position, _) {
                      return MarkerLayer(markers: [
                        Marker(
                          point: position,
                          width: 30,
                          height: 30,
                          child: const Icon(
                            Icons.directions_bus,
                            color: Colors.red,
                            size: 30,
                          ),
                        )
                      ]);
                    })
              ],
            ),
          ),

          // Bus Stops List Section
          Expanded(
            flex: 0,
            child: Column(
              children: [
                // Current and Next Stop Info
                ValueListenableBuilder<LatLng>(
                  valueListenable: _busPosition,
                  builder: (context, position, _) {
                    // Check if current index is within busStops bounds
                    final currentStopName = _currentIndex < busStops.length
                        ? busStops[_currentIndex].trim()
                        : 'End of Route';
                    final nextStopIndex = _currentIndex + 1;
                    final isLastStop = nextStopIndex >= busStops.length;

                    double distance = 0;
                    int minutes = 0;

                    if (!isLastStop && nextStopIndex < _routePoints.length) {
                      final nextPoint = _routePoints[nextStopIndex];
                      distance =
                          const Distance().as(LengthUnit.Meter, position, nextPoint);
                      minutes = (distance / 500).ceil(); // 500m/min ≈ 30km/h
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowBottomNoti(
                          currentStopName: _currentStopName,
                          nextStopName: _nextStopName,
                          distance: _distance,
                        ),
                      ],
                    );
                  },
                ),
                // Stops Lis
              ],
            ),
          ),
        ],
      ),
    );
  }
}
