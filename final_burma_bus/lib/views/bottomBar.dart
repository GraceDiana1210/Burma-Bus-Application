import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex; // Active index
  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    // Define routes corresponding to the navigation items
    final routes = ['/home', '/route', '/payment', '/time', '/noti'];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 'images/home.png', 'Home', 0, routes),
              _buildNavItem(context, 'images/Routing.png', 'Routing', 1, routes),
              const SizedBox(width: 50), // Placeholder space for elevated button
              _buildNavItem(context, 'images/bus_time_2.png', 'Time', 3, routes),
              _buildNavItem(context, 'images/noti.png', 'Notification', 4, routes),
            ],
          ),
          Positioned(
            top: -28, // Adjust position for elevation
            child: _buildHighlightedNavItem(context, 'images/payment.png', 'Payment', 2, routes),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String iconPath, String label, int index, List<String> routes) {
    return GestureDetector(
      onTap: () {
        if (routes[index] == '/map') {
          // Example of dynamically passing data
          context.go(
            '/map',
            extra: {
              'bus21Route': [], // Replace with actual data
              'bus35Route': [], // Replace with actual data
              'bus21Position': null, // Replace with actual data
              'bus35Position': null, // Replace with actual data
              'bus21Stops': [], // Replace with actual data
              'bus35Stops': [], // Replace with actual data
            },
          );
        } else {
          context.go(routes[index]);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: currentIndex == index ? Colors.blueAccent : Colors.black54,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'PuPu',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: currentIndex == index ? Colors.blueAccent : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedNavItem(BuildContext context, String iconPath, String label, int index, List<String> routes) {
    return GestureDetector(
      onTap: () => context.go(routes[index]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 28,
                height: 28,
                color: currentIndex == index ? Colors.blueAccent : Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'PuPu',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: currentIndex == index ? Colors.blueAccent : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}