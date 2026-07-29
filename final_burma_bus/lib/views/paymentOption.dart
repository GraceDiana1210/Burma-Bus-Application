import 'package:flutter/material.dart';
import '../router.dart';
import 'bottomBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentOptions(),
    );
  }
}

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({super.key});

  final List<PaymentOption> paymentOptions = const [
    PaymentOption('images/kpay.png', 'Kpay', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ', KpayScreen()),
    PaymentOption('images/aya.png', 'AYA Pay', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ', Ayapayscreen()),
    PaymentOption('images/wavepay.png', 'Wave Pay', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ', Wavepayscreen()),
    PaymentOption('images/cbPay.png', 'CB Pay', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ', Cbpayscreen()),
    PaymentOption('images/A+.png', 'A+ Wallet', 'ဖြင့်ငွေဖြည့်ရန် နှိပ်ပါ', Apluswalletscreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.amber,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                router.go('/payment');
              },
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            const SizedBox(width: 10),
            const Text("Payment"),
          ],
        ),
      ),
      body: ListView(
        children: paymentOptions
            .map((option) => PaymentOptionTile(option: option))
            .toList(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}

class PaymentOption {
  final String imagePath;
  final String title;
  final String subtitle;
  final Widget targetScreen;

  const PaymentOption(this.imagePath, this.title, this.subtitle, this.targetScreen);
}

class PaymentOptionTile extends StatelessWidget {
  final PaymentOption option;

  const PaymentOptionTile({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => option.targetScreen));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1.5),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(option.imagePath, width: 50, height: 50),
            const SizedBox(width: 15),
            Text(option.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// Placeholder Screens with Popup Logic
class KpayScreen extends StatelessWidget {
  const KpayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kpay')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showPaymentPopup(context, 'Kpay'),
          child: const Text('Show Popup'),
        ),
      ),
    );
  }
}

class Ayapayscreen extends StatelessWidget {
  const Ayapayscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AYA Pay')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showPaymentPopup(context, 'AYA Pay'),
          child: const Text('Show Popup'),
        ),
      ),
    );
  }
}

class Wavepayscreen extends StatelessWidget {
  const Wavepayscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wave Pay')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showPaymentPopup(context, 'Wave Pay'),
          child: const Text('Show Popup'),
        ),
      ),
    );
  }
}

class Cbpayscreen extends StatelessWidget {
  const Cbpayscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CB Pay')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showPaymentPopup(context, 'CB Pay'),
          child: const Text('Show Popup'),
        ),
      ),
    );
  }
}

class Apluswalletscreen extends StatelessWidget {
  const Apluswalletscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A+ Wallet')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showPaymentPopup(context, 'A+ Wallet'),
          child: const Text('Show Popup'),
        ),
      ),
    );
  }
}

// Popup Dialog Function
void _showPaymentPopup(BuildContext context, String paymentMethod) {
  TextEditingController phoneController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('$paymentMethod ဖြင့်ငွေဖြည့်ရန်', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ဖြည့်မည့် ဖုန်းနံပါတ်'),
            TextField(controller: phoneController, decoration: const InputDecoration(hintText: 'ဖုန်းနံပါတ်')),
            const SizedBox(height: 15),
            const Text('မှတ်ချက်'),
            TextField(controller: noteController, decoration: const InputDecoration(hintText: 'မှတ်ချက်')),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$paymentMethod ဖြင့် ငွေဖြည့်ခြင်းအောင်မြင်ပါသည်',
                  style: const TextStyle(fontFamily: 'PuPu', fontSize: 14),
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                  )
                );
              },
              child: const Text('ငွေဖြည့်မည်', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            const Text(
              '*ဖြည့်သွင်းမည့် ဖုန်းနံပါတ် ကို သေချာစစ်ဆေးပါ!',
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ],
        ),
      );
    },
  );
}