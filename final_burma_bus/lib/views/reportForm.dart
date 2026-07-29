import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
class ReportForm extends StatelessWidget {
  const ReportForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  Row(
          children: [
            IconButton(
              onPressed: () {
                context.go('/profile'); // Navigate back to home
              },
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            const SizedBox(width: 10),
            const Text(
              'တိုင်ကြားမည်',
              style: TextStyle(
                fontFamily: "PuPu",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),

              // Email Field
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),

              // Car License Number Field
              const TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Car License Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_bus),
                  hintText: 'Enter your car license plate',
                ),
              ),
              const SizedBox(height: 16),

              // Report Category Dropdown
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(value: 'Driver Report', child: Text('Driver Report')),
                  DropdownMenuItem(value: 'Over Speed', child: Text('Over Speed')),
                  DropdownMenuItem(value: 'Rude Manner', child: Text('Rude Manner')),
                  DropdownMenuItem(value: 'Bugs', child: Text('Bug Report')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) {},
                decoration: const InputDecoration(
                  labelText: 'Report Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Description Field
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  hintText: 'Describe your issue or request in detail',
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Submit Report'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}