import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'noti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final List<String> imageList = [
    'images/home_slider1.jpg',
    'images/home_slider2.jpg',
    'images/home_slider3.jpg',
  ];

  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light gray background
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 40),

            // Profile Section with Divider
            const ProfileSection(),

            const SizedBox(height: 16),

            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                  ),
                  items: imageList.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ရန်ကုန်လမ်းများအားလုံးအတွက်\nဘားမားဘက်စ်နဲ့ရှေ့ဆက်',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4.0,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),


            const SizedBox(height: 15),
            // Title Section
            const Center(
              child: Text(
                'ဘာလုပ်ချင်တာလဲ ?',
                style: TextStyle(
                  fontFamily: "PuPu",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ActionButtons(),
            ),

            const SizedBox(height: 16),

            // Map Section
            const MapPreview(),
            const SizedBox(height: 16),

            // Advertisement Section
            const Center(
              child: Text(
                'ကြော်ငြာဝင်ပါမည်',
                style: TextStyle(
                  fontFamily: "PuPu",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            const FooterAd(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

// Updated Profile Section with Divider
class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person, color: Colors.black),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'မင်္ဂလာပါ Linn',
                    style: TextStyle(
                      fontFamily: "PuPu",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'YBS စီးနေတာလား? ဂရုစိုက်နော်',
                    style: TextStyle(
                      fontFamily: "PuPu",
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),

        // Line Separator
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Divider(
            color: Colors.grey,
            thickness: 0.5, // Thin line
          ),
        ),
      ],
    );
  }
}


class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20), // Add horizontal padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.place_outlined, color: Colors.black, size: 24),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'လမ်းကြောင်းရှာမယ်',
                  style: TextStyle(
                    fontFamily: "PuPu",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20), // Add horizontal padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.directions_bus, color: Colors.black, size: 24),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Bus အချိန် ကြည့်မယ်',
                  style: TextStyle(
                    fontFamily: "PuPu",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ActionButton({super.key, 
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontFamily: "PuPu",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class MapPreview extends StatelessWidget {
  const MapPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'images/mapbg.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FooterAd extends StatelessWidget {
  const FooterAd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'images/foodpanda.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex; // Pass the active index from parent
  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Bottom Navigation Bar
        Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 'images/home.png', 'Home', 0),
              _buildNavItem(context, 'images/Routing.png', 'Routing', 1),
              const SizedBox(width: 50), // Placeholder space for Payment button
              _buildNavItem(context, 'images/bus_time_2.png', 'Time', 3),
              _buildNavItem(context, 'images/noti.png', 'Notification', 4),
            ],
          ),
        ),

        // Elevated Payment Button
        Positioned(
          top: -20,
          child: _buildHighlightedNavItem(context, 'images/payment.png', 'Payment', 2),
        ),
      ],
    );
  }

  // Build Navigation Item
  Widget _buildNavItem(BuildContext context, String iconPath, String label, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
        } else if (index == 4) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
        } else if (index == 2) {
          // Handle Payment Tap
          print("Payment Button Tapped");
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

  // Elevated Payment Button
  Widget _buildHighlightedNavItem(BuildContext context, String iconPath, String label, int index) {
    return Column(
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
    );
  }
}



