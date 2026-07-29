import 'package:flutter/material.dart';

class BurmaCard extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String cardExpiration;
  final String? backgroundImage; // Optional background image

  const BurmaCard({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.cardExpiration,
    this.backgroundImage, // Initialize it as optional
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: backgroundImage != null
              ? DecorationImage(
            image: AssetImage(backgroundImage!),
            fit: BoxFit.cover,
          )
              : null, // If no image, default to null
        ),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                cardNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'CourierPrime',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(label: 'CARDHOLDER', value: cardHolder),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Builds the logos block
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/logo1.png",
          height: 20,
          width: 18,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, color: Colors.white),
        ),
        Image.asset(
          "assets/logo2.png",
          height: 50,
          width: 50,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, color: Colors.white),
        ),
      ],
    );
  }

  // Builds the card detail blocks
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}