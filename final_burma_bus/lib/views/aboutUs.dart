import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC84D), // Yellow Background
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                context.go('/profile'); // Navigate back to home
              },
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            const SizedBox(width: 10),
            const Text(
              'ဘားမားဘတ်စ်အကြောင်းအရာ',
              style: TextStyle(
                fontFamily: "PuPu",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200], // Set background to light grey
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Logo Image Section
          Center(
            child: Image.asset(
              "images/logo.png", // Logo image path
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16.0),
          // Welcome Text
          const Text(
            'Welcome to BURMA BUS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          // Description
          const Text(
            'ဘားမားဘတ်စ်သည် ရန်ကုန်မြို့ရှိ အများပြည်သူအတွက် သယ်ယူပို့ဆောင်ရေး စနစ် (YBS) တွင် ထောက်ပံ့ပေးသော နည်းပညာတိုးတက်သော အများပြည်သူ မော်တော်ယာဉ် ဝန်ဆောင်မှု ဖြစ်ပါသည်။ BURMA Bus ကို အောက်ပါ အချက်အလက်များနှင့် အစီအစဉ်များအား သုံးစွဲသူများအတွက် လွယ်ကူမှုများ ပံ့ပိုးပေးရန် တီထွင်ဖန်တီးခဲ့ပါသည်။',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24.0),
          // Information Cards Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoCard(Icons.flag, 'Mission', 'Empowering innovation.'),
              _buildInfoCard(Icons.visibility, 'Vision', 'Shaping the future.'),
              _buildInfoCard(Icons.people, 'Team', 'Dedicated professionals.'),
            ],
          ),
          const SizedBox(height: 24.0),
          // Feature Sections
          _buildFeatureSection(
            title: 'တည်နေရာ အင်္ဂါရပ် (Location Feature)',
            description:
            '- မိမိ၏ တည်နေရာအခြေပြု၍ အနီးဆုံး YBS မော်တော်ယာဉ်များကို ရှာဖွေပြသပေးသည်။\n'
                '- ယာဉ်တန်း လမ်းကြောင်းများနှင့် ဘတ်စ်ကားရပ်နားစင်တာများကို မြေပုံပေါ်တွင် ပြသပေးသည်။',
          ),
          _buildFeatureSection(
            title: 'အချိန် အင်္ဂါရပ် (Time Feature)',
            description:
            '- ဘတ်စ်ကားများ ရောက်ရှိမည့်အချိန်နှင့် ထွက်ခွာမည့်အချိန်များကို ကြိုတင်သိရှိနိုင်သည်။\n'
                '- အချိန်ကျကျ သယ်ယူပို့ဆောင်မှုများအတွက် အချိန်ဇယားများအား တိကျစွာ ရည်ညွှန်းပေးသည်။',
          ),
          _buildFeatureSection(
            title: 'အွန်လိုင်းငွေပေးချေမှု အင်္ဂါရပ် (Online Payment Feature)',
            description:
            '- QR Code နှင့် မိုဘိုင်းဘဏ်များမှ တဆင့် လွယ်ကူစွာ အွန်လိုင်းငွေပေးချေမှုများ ပြုလုပ်နိုင်သည်။\n'
                '- ပေးချေမှုများအားလုံးသည် သုံးစွဲသူ၏ BURMA Bus အကောင့်တွင် မှတ်တမ်းတင်ထားသည်။',
          ),
          _buildFeatureSection(
            title: 'ငွေပေးချေမှုမှတ်တမ်း ဖြည့်သွင်းခြင်း အင်္ဂါရပ် (Filling Bill Feature)',
            description:
            '- အွန်လိုင်းငွေပေးချေမှုများမှ နောက်ဆက်တွဲ လက်ခံငွေဘောက်ချာများအား သုံးစွဲသူ၏ အကောင့်မှတဆင့် ရယူနိုင်သည်။\n'
                '- လွယ်ကူစွာ ကြည့်ရှုနှိုင်းယှဉ်နိုင်သော လစဉ်ငွေပေးချေမှုမှတ်တမ်းများကို ထည့်သွင်းထားသည်။',
          ),
          _buildFeatureSection(
            title: 'သတိပေးချက် အင်္ဂါရပ် (Alert Feature)',
            description:
            '- ဘတ်စ်ကားရောက်ရှိမည့်အချိန် မီ သတိပေးချက်များပေးပို့သည်။\n'
                '- လမ်းကြောင်း ပြောင်းလဲမှုများနှင့် ဘတ်စ်ကားအခြေအနေ ပြောင်းလဲမှုများကို သုံးစွဲသူများသို့ အချိန်နှင့်တပြေးညီ အသိပေးသည်။',
          ),
          const SizedBox(height: 24.0),
          // Contact Us Button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUsPage()),
              );
            },
            icon: const Icon(Icons.contact_mail),
            label: const Text('Contact Us'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC84D), // Yellow Button Color
              foregroundColor: Colors.black, // Black Text Color
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Information Card Widget
  Widget _buildInfoCard(IconData icon, String title, String description) {
    return Column(
      children: [
        Icon(icon, size: 36, color: Colors.teal),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  // Feature Section Widget
  Widget _buildFeatureSection({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// Contact Us Page
class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text('Contact details go here.'),
      ),
    );
  }
}