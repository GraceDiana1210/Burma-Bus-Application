import 'package:flutter/material.dart';

class ShowBottomNoti extends StatefulWidget {
  final ValueNotifier<String> currentStopName;
  final ValueNotifier<String> nextStopName;
  final ValueNotifier<String> distance;

  const ShowBottomNoti({
    super.key,
    required this.currentStopName,
    required this.nextStopName,
    required this.distance,
  });

  @override
  State<ShowBottomNoti> createState() => _ShowBottomNotiState();
}

class _ShowBottomNotiState extends State<ShowBottomNoti> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Icon(Icons.notifications),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: ValueListenableBuilder<String>(
                  valueListenable: widget.currentStopName,
                  builder: (context, current, _) {
                    return ValueListenableBuilder<String>(
                      valueListenable: widget.nextStopName,
                      builder: (context, next, _) {
                        return ValueListenableBuilder<String>(
                          valueListenable: widget.distance,
                          builder: (context, distance, _) {
                            return Padding(
                              padding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(Icons.close),
                                    color: Colors.black,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.directions_bus, color: Colors.black,),
                                      const SizedBox(width: 10,),
                                      Text(current),
                                      const Text("-"),
                                      Text(next),
                                      const SizedBox(width: 10,),
                                      Text(" $distance m"),
                                    ],
                                  ),

                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}