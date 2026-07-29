import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  final String busLine; // Bus line number
  final String busDirection; // Direction of the bus line
  final List<int> arrivalTimes; // Arrival times for the bus line (as integers)

  const SearchResultPage({
    super.key,
    required this.busLine,
    required this.busDirection,
    required this.arrivalTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Top header with Stack
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: const Text(
                    'ဒီနေရာတွင် ကိုယ်စီးချင်သည့်ကားလိုင်းသည်\nကိုယ်စီးမည့် မှတ်တိုင်သို့ ဘယ်ချိန်ရောက်မလဲ ဆိုတာ ရှာဖွေနိုင်ပါသည်',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "PuPu",
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                left: MediaQuery.of(context).size.width * 0.5 - 90,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'Bus အချိန် ကြည့်မယ်',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "PuPu",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Bus details header
          Container(
            color: Colors.amber[100],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    busLine,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    busDirection,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'PuPu',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Main list
          Expanded(
            child: ListView.builder(
              itemCount: arrivalTimes.length,
              itemBuilder: (context, index) {
                final arrivalTime = arrivalTimes[index];
                Color timeColor;
                String timeLabel;

                if (arrivalTime <= 5) {
                  timeColor = Colors.green;
                  timeLabel = 'မိနစ်';
                } else if (arrivalTime <= 10) {
                  timeColor = Colors.orange;
                  timeLabel = 'မိနစ်';
                } else {
                  timeColor = Colors.red;
                  timeLabel = 'မိနစ်';
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          busLine,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        busDirection,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'PuPu',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: timeColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$arrivalTime $timeLabel',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.info, color: Colors.grey[600]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
