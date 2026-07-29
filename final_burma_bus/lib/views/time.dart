import 'package:flutter/material.dart';
import 'package:final_burma_bus/views/bottomBar.dart';
import 'SearchResultPage.dart';
import 'dart:math';


// Data structure for bus connections
class BusConnection {
  final List<String> stops;
  final double distance;
  final String line;

  BusConnection(this.stops, this.distance, this.line);
}

// List of bus connections
final List<BusConnection> busConnections = [
  BusConnection(
    [
      "၆၅ဂိတ်",
      "သိမ်းချောင်း",
      "ရွှေပြည်သာလိန်",
      "ကွက်သစ်",
      "ဒဒွေး",
      "လှော်ကားအောက်ဂိတ်",
      "မိုးဆန်း",
      "တရုံးရှေ့",
      "အိမ်မဲကြီး",
      "အောင်ချမ်းသာ",
      "အောင်မေတ္တာ",
      "ဏဈေး",
      "ငြိမ်းချမ်းရေး",
      "အမိုးကြီး",
      "ဏကွေ့",
      "ရုံးရှေ့",
      "ကိူးသုံးလုံး",
      "ဆင်နှစ်ကောင်",
      "၃ထိပ်",
      "ငမောက်ဈေး",
      "ရေချမ်းစင်",
      "နဝရတ်ဈေး",
      "ကျော်စွာ",
      "တော်ဝင်",
      "ရွှေညာမောင်",
      "ကားကြီးဂိတ်",
      "ဆေးခန်း",
      "ထန်း‌ခြောက်ပင်",
      "ကားလေးဂိတ်",
      "ခေါင်းသုံးလုံး",
      "သံလမ်း",
      "ရေစင်",
      "ရွှေပြည်သာကွေ့",
      "စစ်တပ်",
      "ကျောင်းလမ်း",
      "ကန်သာယာ",
      "မြင်းလှည်းဂိတ်",
      "ဘုန်းကြီးကျောင်း",
      "ဆောက်လုပ်ရေး",
      "ဒညင်းကုန်းလမ်းဆုံ",
      "ဘိုခြံ",
      "ရွာသစ်",
      "အောင်ဆန်းဈေး",
      "ကျောင်းဂိတ်",
      "၁ဂိတ်",
      "စောင်စက်ရုံ(၂)",
      "ဖော့ကန်ဈေး",
      "ဂျပန်လမ်း",
      "ပြည်တော်သာ",
      "သရက်တော(အင်းစိန်)",
      "ဘိုကုန်း",
      "ဟိုက်ပက်",
      "မညက",
      "အင်းစိန်ဆေးရုံ",
      "အင်းစိန်ပန်းခြံ",
      "ဘီအိုစီ",
      "ကြို့ကုန်း",
      "ဘီပီအိုင်(YTU)",
      "ခဝဲခြံ",
      "ကုလားကျောင်း",
      "သမိုင်းလမ်းဆုံ",
      "ဘုရားလမ်း",
      "အုတ်ကျင်း",
      "ဘာတာ",
      "သံလမ်း",
      "သုခလမ်း",
      "ဘူတာရုံလမ်း",
      "ဆင်ရေတွင်း",
      "စံရိပ်ငြိမ်",
      "လှည်းတန်း",
      "စိုက်ပျိုးရေး",
      "ဟံသာဝတီအဝိုင်း",
      "မဟာမြိုင်",
      "မြေနီကုန်း",
      "လင့်လမ်း",
      "အုတ်လမ်း",
      "ရွှေဂုံတိုင်",
      "ဗန်ဒါပင်",
      "၅ထပ်ကြီး",
      "၆ထပ်ကြီး",
      "တာမွေအဝိုင်း",
      "တာမွေပလာဇာ",
      "တာမွေဈေး",
      "ကျောက်မြောင်းဈေး",
      "သီတာ",
      "အောင်မင်္ဂလာ",
      "ယုဇနပလာဇာ",
      "မင်္ဂလာဈေး",
      "ပုဇွန်တောင်စာတိုက်",
      "ပုဇွန်တောင်ဈေး",
      "ညောင်တန်း",
      "မဆလာစက်/ဂန္ဒီ",
      "ဆီဆိုင်",
      "ဗိုလ်တထောင်ဘုရား"
    ],
    50.0, // Total distance in km
    "65",
  ),
  BusConnection(
    [
      "အနောက်ပိုင်းနည်းပညာတက္ကသိုလ်",
      "မြစိမ်းရောင်",
      "ဆောက်လုပ်ရေး",
      "ဒဂုံဧရာအဝေးပြေး",
      "သမကုန်း",
      "ဘီအိုစီ",
      "စနေမ",
      "၅ထိပ်",
      "မီးခွက်ဈေး",
      "တံတားဖြူ",
      "ရုံးရှေ့",
      "၅ထိပ်",
      "၃ထိပ်",
      "၁ထိပ်",
      "အင်းစိန်ကမ်းနား",
      "ပေါက်တောဝ",
      "ညောင်ပင်",
      "မြို့သစ်ဈေး",
      "ပိတောက်လမ်း",
      "ကြို့ကုန်း",
      "ဘုရင့်နောင်ဈေးပွဲရုံ",
      "ဓမ္မာရုံ",
      "ဘုရင့်နောင်လမ်းဆုံ",
      "ဈေးဘူတာ",
      "ဦးဘဟန်",
      "ကြွေ ၁",
      "သမိုင်းလမ်းဆုံ",
      "ဘုရားလမ်း",
      "အုတ်ကျင်း",
      "ဘာတာ",
      "သံလမ်း",
      "သုခလမ်း",
      "ဘူတာရုံလမ်း",
      "ဆင်ရေတွင်း",
      "စံရိပ်ငြိမ်",
      "လှည်းတန်း",
      "စိုက်ပျိုးရေး",
      "ဟံသာဝတီအဝိုင်း",
      "မဟာမြိုင်",
      "မြေနီကုန်း",
      "မြေနီကုန်း",
      "လင့်လမ်း",
      "အုတ်လမ်း",
      "ရွှေဂုံတိုင်",
      "ရွှေဂုံတိုင်",
      "ရေခဲဆိုင်",
      "ဗဟန်း၃လမ်း",
      "ကျောက်တိုင်",
      "ယောက်လမ်း (သမ္မတ)",
      "ဆူးလေ (မြို့တော်ခန်းမ)"
    ],
    45.0, // Total distance in km
    "61",
  ),
  BusConnection(
    [
      "အနောက်ပိုင်းတက္ကသိုလ်",
      "အဝိုင်း",
      "မိုင် (၂၀)",
      "ဧရာမြေ",
      "၁၉၉",
      "(၁၄) လမ်းဆုံ",
      "ဘူတာဈေး",
      "ဒညင်းကုန်းလမ်းဆုံ",
      "ဘိုခြံ",
      "ရွာသစ်",
      "အောင်ဆန်းဈေး",
      "ကျောင်းဂိတ်",
      "(၁) ဂိတ်",
      "ဆောင် (၂)",
      "ဖော့ကန်ဈေး",
      "ဂျပန်လမ်း",
      "ပြည်တော်သာ/(GTI)ထိပ်",
      "ပြည်တော်သာ",
      "သရက်တော",
      "ဗိုလ်ကုန်း",
      "ဟိုက်ပက်",
      "မညက",
      "အင်းစိန်ဆေးရုံကြီး",
      "အင်းစိန်ပန်းခြံ",
      "ဘီအိုစီ",
      "ကြို့ကုန်း",
      "ဘီပီအိုင်",
      "ခဝဲခြံ",
      "ကုလားကျောင်း",
      "သမိုင်းလမ်းဆုံ",
      "ဘုရားလမ်း",
      "အုတ်ကျင်း",
      "ဘာတာ",
      "သံလမ်း",
      "သုခ",
      "ဘူတာရုံလမ်း",
      "ဆင်ရေတွင်း",
      "စံရိပ်ငြိမ်",
      "လှည်းတန်း",
      "စိုက်ပျိုးရေး",
      "ဟံသာဝတီ",
      "မဟာမြိုင်",
      "မြေနီကုန်း",
      "ဟယ်(လ်)ပင်",
      "ပဲခူးကလပ်",
      "စိန်ဂျွန်",
      "စံပြ",
      "ဘုန်းကြီးလမ်း",
      "မော်တင်"
    ],
    30.0, // Total distance in km
    "21",
  ),
  BusConnection(
    [
      "အနောက်ပိုင်းတက္ကသိုလ်",
      "အဝိုင်း",
      "မိုင် (၂၀)",
      "ဧရာမြေ",
      "၁၉၉",
      "(၁၄) လမ်းဆုံ",
      "ဘူတာဈေး",
      "ဒညင်းကုန်းလမ်းဆုံ",
      "ဘိုခြံ",
      "ရွာသစ်",
      "အောင်ဆန်းဈေး",
      "ကျောင်းဂိတ်",
      "(၁) ဂိတ်",
      "ဆောင် (၂)",
      "ဖော့ကန်ဈေး",
      "ဂျပန်လမ်း",
      "ပြည်တော်သာ/(GTI)ထိပ်",
      "ပြည်တော်သာ",
      "သရက်တော",
      "ဗိုလ်ကုန်း",
      "ဟိုက်ပက်",
      "မညက",
      "အင်းစိန်ဆေးရုံကြီး",
      "အင်းစိန်ပန်းခြံ",
      "ဘီအိုစီ",
      "ကြို့ကုန်း",
      "ဘီပီအိုင်",
      "ခဝဲခြံ",
      "ကုလားကျောင်း",
      "သမိုင်းလမ်းဆုံ",
      "ဘုရားလမ်း",
      "အုတ်ကျင်း",
      "ဘာတာ",
      "သံလမ်း",
      "သုခ",
      "ဘူတာရုံလမ်း",
      "ဆင်ရေတွင်း",
      "စံရိပ်ငြိမ်",
      "လှည်းတန်း",
      "စိုက်ပျိုးရေး",
      "ဟံသာဝတီ",
      "မဟာမြိုင်",
      "မြေနီကုန်း",
      "ဟယ်(လ်)ပင်",
      "ပဲခူးကလပ်",
      "စိန်ဂျွန်",
      "စံပြ",
      "ဘုန်းကြီးလမ်း",
      "မော်တင်"
    ],
    40.0, // Total distance in km
    "131",
  ),
  BusConnection(
    [
      "ဘီအာတီဂိတ်ဟောင်း",
      "ဘုရားလေးကွေ့",
      "ညောင်ပင်(ထောက်ကြန့်)",
      "ထောက်ကြန့်လမ်းဆုံ",
      "ပုပ္ပါးကျောင်း",
      "လမ်းသစ်(ထောက်ကြန့်)",
      "ကျောင်းရှေ့(ထောက်ကြန့်)",
      "နွယ်ခွေ(ပြည်လမ်း)",
      "ဒေဝူးနာရီစင်",
      "မွေးမြူရေး",
      "ရေစင်",
      "ခြံပေါက်(ပျဉ်းမပင်)",
      "ကုန်းထိပ်",
      "ဘုရားလေး",
      "ရဲဘော်ဟောင်း(မင်္ဂလာဒုံ)",
      "ရှမ်းစု",
      "ဘိုခြံ(မင်္ဂလာဒုံ)",
      "တစ်နံပါတ်",
      "ဗိုလ်ရွေး",
      "ရေကြည်အိုင်",
      "ဝါယာလက်",
      "ကျိုက္ကလို့",
      "ကျိုက္ကလဲ့/ဆပ်ပလိုင်း",
      "ဗဟိုနိုင်ငံရေး",
      "မင်္ဂလာဒုံဈေး",
      "ခရေပင်လမ်းခွဲ(ပြည်လမ်း)",
      "မင်္ဂလာဒုံစာတိုက်",
      "ဆေးကျောင်း(မင်္ဂလာဒုံ)",
      "ဘီအိုစီ(မင်္ဂလာဒုံ)",
      "ပန်းခြံကုန်း",
      "ကုလားဘုရား(မင်္ဂလာဒုံ)",
      "ထန်းပင်ကုန်း",
      "စော်ဘွားကြီးကုန်းလမ်းဆုံ",
      "ကျောက်တော်ကြီးဘုရား",
      "၁၀မိုင်ကုန်း",
      "၉မိုင်ခွဲ",
      "၉မိုင်",
      "အေဝမ်း",
      "မဟာစည်",
      "၈မိုင်",
      "၇မိုင်",
      "အေဒီ",
      "ကျောင်းကွေ့",
      "၆မိုင်ခွဲ",
      "တံတားဖြူ",
      "မာလာ",
      "စိုက်ပျိုးရေး",
      "ဟံသာဝတီအဝိုင်း",
      "မဟာမြိုင်",
      "မြေနီကုန်း",
      "ဟယ်လ်ပင်",
      "ပဲခူးကလပ်",
      "စိန်ဂျွန်း",
      "သရက်တောကျောင်း",
      "ဆေးရုံကြီး",
      "ဗိုလ်ချုပ်ဈေး",
      "ဆူးလေ (မြို့တော်ခန်းမ)",
      "၆ ထပ်ရုံး"
    ],
    40.0, // Total distance in km
    "37",
  ),
  BusConnection(
    [
      "ဝါယာလက်",
      "ကျိုက္ကလို့",
      "ကျိုက္ကလဲ့/ဆပ်ပလိုင်း",
      "ဗဟိုနိုင်ငံရေး",
      "မင်္ဂလာဒုံဈေး",
      "ခရေပင်လမ်းခွဲ (ပြည်လမ်း)",
      "မင်္ဂလာဒုံစာတိုက်",
      "ဆေးကျောင်း (မင်္ဂလာဒုံ)",
      "ဘီအိုစီ (မင်္ဂလာဒုံ)",
      "ပန်းခြံကုန်း",
      "ကုလားဘုရား (မင်္ဂလာဒုံ)",
      "ထန်းပင်ကုန်း",
      "စော်ဘွားကြီးကုန်းလမ်းဆုံ",
      "ကျောက်တော်ကြီးဘုရား",
      "၁၀ မိုင်ကုန်း",
      "၉ မိုင်ခွဲ",
      "၉ မိုင်",
      "အေဝမ်း",
      "မဟာစည်",
      "၈ မိုင်",
      "၇ မိုင်",
      "အေဒီ",
      "ကျောင်းကွေ့",
      "၆ မိုင်ခွဲ",
      "တံတားဖြူ",
      "မာလာ",
      "စိုက်ပျိုးရေး",
      "ဟံသာဝတီအဝိုင်း",
      "မဟာမြိုင်",
      "မြေနီကုန်း",
      "ဟယ်လ်ပင်",
      "ပဲခူးကလပ်",
      "စိန်ဂျွန်း",
      "သရက်တောကျောင်း",
      "ဆေးရုံကြီး",
      "ဗိုလ်ချုပ်ဈေး",
      "ဆူးလေ (မြို့တော်ခန်းမ)",
      "၆ ထပ်ရုံး"
    ],
    40.0, // Total distance in km
    "104",
  ),
  BusConnection(
    [
      "TU စီမံကိန်း",
      "အုန်းခြံ",
      "ဒေါင်းလေးကွေ့",
      "ဘုရားလမ်းဈေး",
      "မင်္ဂလာတိုက်",
      "စုပေါင်းရုံး",
      "ပေါ်တော်မူ",
      "ရွှေပြည်အေး",
      "ဆီစက် (ချမ်းမြေ့ရိပ်သာ)",
      "အမှတ်၇",
      "ထန်းတပင်တာဆုံ",
      "လျှပ်စစ်ရုံး (မှော်ဘီ)",
      "ကားလေးဂိတ်",
      "မှော်ဘီဈေး",
      "ရုပ်ရှင်ရုံဟောင်း",
      "ဘူတာကွေ့",
      "စာတိုက် (မှော်ဘီ)",
      "အမှတ်၄လမ်းထိပ်",
      "ရုံးပေါက်",
      "လေထီး ၁၆",
      "ဆပ်ပလိုင်း (မှော်ဘီ)",
      "ဂျီအီး",
      "လေတပ်",
      "မော်တော်ယာဉ်",
      "ဗိုလ်သင်တန်း",
      "ဆက်သွယ်ရေး (မှော်ဘီ)",
      "၉၁ဂိတ်ကြီး",
      "ဆပ်သွားတော ဘုန်းကြီးကျောင်း",
      "မိန်းမလိုင်း",
      "ဂျပန်ဘုရား (စမ်းချောင်းပေါက်)",
      "ရဲဘော်ဈေး",
      "ကြက်ဖြူကန်ကျောင်းရှေ့",
      "အသုံးလူံး",
      "ဆေးခန်း (မှော်ဘီ)",
      "မီးစက်",
      "ကိုးလုံကွင်း ဘုန်းကြီးကျောင်း",
      "မင်္ဂလာဈေး",
      "တင့်ကား",
      "ရုံသံ",
      "၂ဂိတ်",
      "ရေအိုးစ် (ပက်စီ)",
      "ဆောက်လုပ်ရေး",
      "၈၂ဂိတ်ကြီး",
      "စက္ကူစက်",
      "၉ဂိတ်",
      "ဘီအာတီဂိတ်ဟောင်း",
      "ဘုရားလေးကွေ့",
      "ညောင်ပင် (ထောက်ကြန့်)",
      "ထောက်ကြန့်လမ်းဆုံ",
      "ပုပ္ပါးကျောင်း",
      "လမ်းသစ် (ထောက်ကြန့်)",
      "ကျောင်းရှေ့ (ထောက်ကြန့်)",
      "နွယ်ခွေ (ပြည်လမ်း)",
      "ဒေဝူးနာရီစင်",
      "မွေးမြူရေး",
      "ရေစင်",
      "ခြံပေါက် (ပျဉ်းမပင်)",
      "ကုန်းထိပ်",
      "ဘုရားလေး",
      "ရဲဘော်ဟောင်း (မင်္ဂလာဒုံ)",
      "ရှမ်းစု",
      "ဘိုခြံ (မင်္ဂလာဒုံ)",
      "တစ်နံပါတ်",
      "ဗိုလ်ရွေး",
      "ရေကြည်အိုင်",
      "ဝါယာလက်",
      "ကျိုက္ကလို့",
      "ကျိုက္ကလဲ့/ဆပ်ပလိုင်း",
      "ဗဟိုနိုင်ငံရေး",
      "မင်္ဂလာဒုံဈေး",
      "ခရေပင်လမ်းခွဲ (ပြည်လမ်း)",
      "မင်္ဂလာဒုံစာတိုက်",
      "ဆေးကျောင်း (မင်္ဂလာဒုံ)",
      "ဘီအိုစီ (မင်္ဂလာဒုံ)",
      "ပန်းခြံကုန်း",
      "ကုလားဘုရား (မင်္ဂလာဒုံ)",
      "ထန်းပင်ကုန်း",
      "စော်ဘွားကြီးကုန်းလမ်းဆုံ",
      "ကျောက်တော်ကြီးဘုရား",
      "၁၀ မိုင်ကုန်း",
      "၉ မိုင်ခွဲ",
      "၉ မိုင်",
      "အေဝမ်း",
      "မဟာစည်",
      "၈ မိုင်",
      "၇ မိုင်",
      "အေဒီ",
      "ကျောင်းကွေ့",
      "၆ မိုင်ခွဲ",
      "တံတားဖြူ",
      "မာလာ",
      "စိုက်ပျိုးရေး",
      "ဟံသာဝတီအဝိုင်း",
      "မဟာမြိုင်",
      "မြေနီကုန်း",
      "ဟယ်လ်ပင်",
      "ပဲခူးကလပ်",
      "စိန်ဂျွန်း",
      "သရက်တောကျောင်း",
      "ဆေးရုံကြီး",
      "ဗိုလ်ချုပ်ဈေး",
      "ဆူးလေ (မြို့တော်ခန်းမ)",
      "၆ ထပ်ရုံး"
    ],
    40.0, // Total distance in km
    "107",
  ),
  BusConnection(
    [
      "ရွှေပြည်သာ (ရဲသင်တန်းကျောင်း)",
      "လှော်ကားတာဆုံ",
      "လှော်ကားကျောင်းရှေ့",
      "လှော်ကားဂိတ်ဟောင်း",
      "ဈေးသံလမ်း",
      "ဘုရားလေး",
      "ဂျိုကာ",
      "လှော်ကားအောက်ဂိတ်",
      "မိုးဆန်း",
      "တရုံးရှေ့",
      "အိမ်မဲကြီး",
      "အောင်ချမ်းသာ",
      "အောင်မေတ္တာ",
      "ဏဈေး",
      "ငြိမ်းချမ်းရေး",
      "အမိုးကြီး",
      "ဏကွေ့",
      "ရုံးရှေ့",
      "ကိူးသုံးလုံး",
      "ဆင်နှစ်ကောင်",
      "၃ထိပ်",
      "ငမောက်ဈေး",
      "ရေချမ်းစင်",
      "နဝရတ်ဈေး",
      "ကျော်စွာ",
      "တော်ဝင်",
      "ရွှေညာမောင်",
      "ကားကြီးဂိတ်",
      "ဆေးခန်း",
      "ထန်း‌ခြောက်ပင်",
      "ကားလေးဂိတ်",
      "၈၁ ဂိတ်",
      "ပျော်ဘွယ်",
      "ဇင်‌ယော်",
      "ပုလဲလမ်းဆုံ",
      "ဘုန်းကြီးကျောင်းကွေ့",
      "တံတားထိပ်",
      "၁၉၉ ဂိတ်ဟောင်း",
      "၁၄ လမ်းဆုံ",
      "ဒညင်းကုန်းဘူတာဈေး",
      "ဒညင်းကုန်းလမ်းဆုံ",
      "ဘိုခြံ",
      "ရွာသစ်",
      "အောင်ဆန်းဈေး",
      "ကျောင်းဂိတ်",
      "၁ ဂိတ်",
      "စောင်စက်ရုံ (၂)",
      "ဖော့ကန်ဈေး",
      "ဂျပန်လမ်း",
      "ပြည်တော်သာ",
      "သရက်တော (အင်းစိန်)",
      "ဘိုကုန်း",
      "ဟိုက်ပက်",
      "မညက",
      "အင်းစိန်ဆေးရုံ",
      "အင်းစိန်ပန်းခြံ",
      "ဘီအိုစီ",
      "ကြို့ကုန်း",
      "ဘီပီအိုင် (YTU)",
      "ခဝဲခြံ",
      "ကုလားကျောင်း",
      "သမိုင်းလမ်းဆုံ",
      "ဘုရားလမ်း",
      "အုတ်ကျင်း",
      "ဘာတာ",
      "သံလမ်း",
      "သုခလမ်း",
      "ဘူတာရုံလမ်း",
      "ဆင်ရေတွင်း",
      "စံရိပ်ငြိမ်",
      "လှည်းတန်း",
      "စိုက်ပျိုးရေး",
      "ဟံသာဝတီအဝိုင်း",
      "မဟာမြိုင်",
      "မြေနီကုန်း",
      "မြေနီကုန်း",
      "လင့်လမ်း",
      "အုတ်လမ်း",
      "ရွှေဂုံတိုင်",
      "ဗန်ဒါပင်",
      "၅ ထပ်ကြီး",
      "၆ ထပ်ကြီး",
      "တာမွေအဝိုင်း",
      "တာမွေပလာဇာ",
      "တာမွေဈေး",
      "ကျောက်မြောင်းဈေး",
      "သီတာ",
      "အောင်မင်္ဂလာ",
      "ယုဇနပလာဇာ",
      "မင်္ဂလာဈေး",
      "ပုဇွန်တောင်စာတိုက်",
      "ပုဇွန်တောင်ဈေး",
      "ညောင်တန်း",
      "မဆလာစက်/ ဂန္ဒီ",
      "ဆီဆိုင်",
      "ဗိုလ်တထောင်ဘုရား"
    ],
    40.0, // Total distance in km
    "145",
  ),
  BusConnection(
    [
      "၈ဂိတ်အစ",
      "ဒဂုံဆိပ်ကမ်း (၁၆၈ရပ်ကွက်)",
      "၅ထိပ်(ရိုးမရိပ်သာ)",
      "၈၉ဂိတ်ဟောင်း",
      "ဈေးရှေ့",
      "ဆေးရုံကွေ့",
      "စက်ရုံကွေ့",
      "ကနောင်အိမ်ရာ",
      "ပိုလီမာ",
      "၈၉လမ်းဆုံ",
      "ကျောက်လမ်း",
      "မြေနီလမ်း",
      "ကြိုဆိုရေး",
      "မြနန္ဒာ",
      "ရတနာလမ်း",
      "ပွိုင့်ထိပ်",
      "အထူးဂိတ်",
      "အင်းဝအိမ်ရာ",
      "သိမ်ချောင်းလမ်းဆုံ",
      "၆၅",
      "ဆောက်လုပ်ရေး",
      "စာဥ",
      "သစ်ဆိပ်",
      "ဒုဌဝတီ",
      "သံလမ်းကွေ့",
      "ဘုရားလေးကွေ့",
      "၃၄ကားကြီးဂိတ်",
      "၁၀ဈေး",
      "သာကေတအဝိုင်း",
      "ဓမ္မာရုံ",
      "ခိုင်ရွှေဝါ",
      "အရက်ဆိုင်ကွေ့",
      "ဝေဇယန္တာ",
      "ဂိတ်ဟောင်း",
      "၇ဈေး",
      "ကျန်းမာရေး",
      "ရုပ်ရှင်ရုံ",
      "နယ်မြေရုံး",
      "စာတိုက်",
      "ဆီဆိုင်",
      "ခင်မမကြား",
      "၃ဈေး",
      "အရှေ့ကြား",
      "၃ဂိတ်ဟောင်း",
      "မာန်ပြေ",
      "ရန်ပြေ",
      "သဘော်ကျင်း",
      "ဝါဆို",
      "မင်္ဂလာဈေး",
      "ဘီအိုစီ",
      "မျက်စိဆေးရုံ",
      "ဖိုးစိန်လမ်း",
      "နတ်မောက်ကျောင်းရှေ့",
      "ဂျမား",
      "ဗဟန်း၃လမ်း",
      "ရွှေတိဂုံဘုရား (တောင်ဘက်မုဒ်)",
      "ဆက်သွယ်ရေး",
      "ဆောက်လုပ်ရေး",
      "လေဟာပြင်ဈေး",
      "လသာ"
    ],
    40.0, // Total distance in km
    "134",
  ),
  BusConnection(
    [
      "၈ဂိတ်အစ",
      "ဒဂုံဆိပ်ကမ်း (၁၆၈ရပ်ကွက်)",
      "၅ထိပ်(ရိုးမရိပ်သာ)",
      "၈၉ဂိတ်ဟောင်း",
      "ဈေးရှေ့",
      "ဆေးရုံကွေ့",
      "စက်ရုံကွေ့",
      "ကနောင်အိမ်ရာ",
      "ပိုလီမာ",
      "၈၉လမ်းဆုံ",
      "ကျောက်လမ်း",
      "မြေနီလမ်း",
      "ကြိုဆိုရေး",
      "မြနန္ဒာ",
      "ရတနာလမ်း",
      "ပွိုင့်ထိပ်",
      "အထူးဂိတ်",
      "အင်းဝအိမ်ရာ",
      "သိမ်ချောင်းလမ်းဆုံ",
      "၆၅",
      "ဆောက်လုပ်ရေး",
      "စာဥ",
      "သစ်ဆိပ်",
      "ဒုဌဝတီ",
      "သံလမ်းကွေ့",
      "ဘုရားလေးကွေ့",
      "၃၄ကားကြီးဂိတ်",
      "၁၀ဈေး",
      "သာကေတအဝိုင်း",
      "ဓမ္မာရုံ",
      "ခိုင်ရွှေဝါ",
      "အရက်ဆိုင်ကွေ့",
      "ဝေဇယန္တာ",
      "ဂိတ်ဟောင်း",
      "၇ဈေး",
      "ကျန်းမာရေး",
      "ရုပ်ရှင်ရုံ",
      "နယ်မြေရုံး",
      "စာတိုက်",
      "ဆီဆိုင်",
      "ခင်မမကြား",
      "၃ဈေး",
      "အရှေ့ကြား",
      "၃ဂိတ်ဟောင်း",
      "မာန်ပြေ",
      "ရန်ပြေ",
      "သဘော်ကျင်း",
      "ဝါဆို",
      "မင်္ဂလာဈေး",
      "ဘီအိုစီ",
      "မျက်စိဆေးရုံ",
      "ဖိုးစိန်လမ်း",
      "နတ်မောက်ကျောင်းရှေ့",
      "ဂျမား",
      "ဗဟန်း၃လမ်း",
      "ရွှေတိဂုံဘုရား (တောင်ဘက်မုဒ်)",
      "ဆက်သွယ်ရေး",
      "ဆောက်လုပ်ရေး",
      "လေဟာပြင်ဈေး",
      "လသာ"
    ],
    40.0, // Total distance in km
    "4",
  ),
  BusConnection(
    [
      "ကန်ကြီးထောင့်",
      "ဆောက်လုပ်ရေး",
      "လယ်ယာဂိတ်ရင်း",
      "၁၀ဈေး",
      "သာကေတအဝိုင်း",
      "ဓမ္မာရုံ",
      "ခိုင်ရွှေဝါ",
      "အရက်ဆိုင်ဂိတ်",
      "၁၃ဂိတ်",
      "၄၉အစိမ်းဂိတ်",
      "ကြယ်ငါးပွင့်",
      "ဝေဇယန္တာ",
      "၅ကွေ့",
      "ရုပ်ရှင်ရုံ",
      "ထူပါရုံ",
      "အနော်မာ",
      "၁ဈေးကွေ့",
      "တပ်ဖွဲ့",
      "မြေနီ",
      "ကျောက်တိုင်",
      "တံတားဟောင်း (တရားရုံး)",
      "ပုသိမ်ညွန့် (၆လမ်း)",
      "အာသောက",
      "တာမွေဗလီ",
      "တာမွေစျေး",
      "ကျောက်မြောင်းစျေး",
      "သီတာ",
      "အောင်မင်္ဂလာ",
      "ယုဇနပလာဇာ",
      "မင်္ဂလာဈေး (၁၂၄လမ်း)",
      "မဆလာစက်",
      "၉၁လမ်း",
      "၈၈လမ်း",
      "ယောက်လမ်း (သမ္မတ)",
      "ဆူးလေ (မြို့တော်ခန်းမ)"
    ],
    40.0, // Total distance in km
    "72",
  ),
  BusConnection(
    [
      "ဒဂုံတက္ကသိုလ်",
      "မုခ်ဝ",
      "ဂိတ်ဟောင်း",
      "ဈေးလေး",
      "စိန်ပန်း",
      "၄၆လမ်းဆုံ (ညာ)",
      "၄၆လမ်းဆုံ (ဘယ်)",
      "ကြားမှတ်တိုင်",
      "ဗထူးဈေး",
      "ဗညားဒလ",
      "ကျောင်းလေးရှေ့",
      "၄၄",
      "ကျန်းမာရေး",
      "ကျောင်းကွေ့",
      "ဖြိုးစပယ်",
      "ခေမာ",
      "ဂန္ဓာရုံ",
      "ဂိတ်ဟောင်း",
      "မြောက်ဥက္ကလာအဝိုင်း",
      "ကျောက်ရေတွင်း",
      "ဘုန်းကြီးလမ်း",
      "၂ဈေး",
      "၅လမ်း",
      "လမ်းဝ",
      "ကမ္ဘာအေးစာတိုက်",
      "ကမ္ဘာအေးဘုရား",
      "ချော်တွင်းကုန်း",
      "မဉ္ဇူလမ်း",
      "ပါရမီညောင်ပင်",
      "ကေတုမာလာကွေ့",
      "တကောင်း",
      "နန္ဒဝန်ဈေး",
      "အင်းဝ",
      "တောင်ဥက္ကလာစာတိုက်",
      "ရုံးရှေ့",
      "ပဒေသာ",
      "၁၄/၁၅ လမ်းဆုံ",
      "အောင်ရတနာ",
      "သရက်တော",
      "ဇဝနလမ်းဆုံ",
      "ခပ်ချီးယား",
      "အသင်းတိုက်",
      "သုဝဏ္ဏဘောလုံးကွင်း",
      "သုဝဏ္ဏလမ်းဆုံ",
      "ကျောက်တိုင်",
      "မြေနီ",
      "တပ်ဖွဲ့",
      "၁ဈေးကွေ့",
      "အနော်မာ",
      "ထူပါရုံ",
      "ရုပ်ရှင်ရုံ",
      "၅ကွေ့",
      "ဝေဇယန္တာ",
      "ကြယ်ငါးပွင့်",
      "၄၉အစိမ်းဂိတ်",
      "ခန်းမ",
      "ဂိတ်ဝ",
      "၁၃ဂိတ်",
      "ကန်ကြီးထောင့်"
    ],
    40.0, // Total distance in km
    "10",
  ),

  // Add more bus connections here
];

class BusSearchPage extends StatefulWidget {
  const BusSearchPage({super.key});

  @override
  _BusSearchPageState createState() => _BusSearchPageState();
}

class _BusSearchPageState extends State<BusSearchPage> {
  String selectedBusLine = '';
  String errorMessage = '';
  List<String> filteredStops = [];
  List<String> filteredBusLines = [];
  final TextEditingController stopSearchController = TextEditingController();

  void filterBusLines(String busStop) {
    setState(() {
      if (busStop.isEmpty) {
        filteredBusLines = [];
      } else {
        filteredBusLines = busConnections
            .where((connection) => connection.stops.contains(busStop))
            .map((connection) => connection.line)
            .toSet() // Use a Set to ensure uniqueness
            .toList();
      }
    });
  }

  void filterBusStops(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredStops = [];
      });
    } else {
      setState(() {
        filteredStops = busConnections
            .expand((connection) => connection.stops) // Access all stops from all connections
            .where((stop) => stop.startsWith(query)) // Filter stops that start with the query
            .toList(); // Convert the iterable to a list
      });
    }
  }

  // Wrapper function to call both filterBusStops and filterBusLines
  void onBusStopSearchChanged(String query) {
    filterBusStops(query); // Filter the stops first
    filterBusLines(query); // Filter the bus lines based on the input stop
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          // Header Section
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
                  padding: const EdgeInsets.only( left: 20, right: 20),
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
          const SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search Field for bus stops
                  TextField(
                    controller: stopSearchController,
                    onChanged: onBusStopSearchChanged,
                    decoration: const InputDecoration(
                      hintText: 'စီးမည့် မှတ်တိုင် ကိုရိုက်ပါ',
                      suffixIcon: Icon(Icons.search, color: Colors.black54),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                    ),
                  ),
                  // No SizedBox between search bar and dropdown
                  if (filteredStops.isNotEmpty)
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true, // To make the scrollbar visible
                        child: ListView.builder(
                          itemCount: filteredStops.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filteredStops[index]),
                              onTap: () {
                                // Update the TextEditingController with the selected stop
                                stopSearchController.text = filteredStops[index];

                                // Call filterBusLines to update the dropdown menu
                                filterBusLines(filteredStops[index]);

                                // Clear the filtered stops to hide the dropdown list
                                setState(() => filteredStops = []);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  // Dropdown for bus lines

                  // Dropdown for bus lines filtered by bus stop
                  DropdownButtonFormField<String>(
                    value: filteredBusLines.isNotEmpty ? filteredBusLines.first : null, // Assign first valid value
                    hint: const Text('စီးချင်သည့် ကားလိုင်း ကို ရွေးပါ (ဥပမာ - ၃၅)'),
                    items: filteredBusLines.toSet().map((line) {  // Convert to Set to remove duplicates
                      return DropdownMenuItem<String>(
                        value: line,
                        child: Text(line),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (filteredBusLines.contains(value)) {  // Ensure selected value exists in list
                        setState(() {
                          selectedBusLine = value!;
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedBusLine.isEmpty || stopSearchController.text.isEmpty) {
                        setState(() {
                          errorMessage = 'ရှာဖွေရန် အချက်အလက်မပြည့်စုံပါ';
                        });
                      } else {
                        setState(() {
                          errorMessage = '';
                        });

                        // Find the selected bus connection by bus line
                        final selectedConnection = busConnections.firstWhere(
                              (connection) => connection.line == selectedBusLine,
                          orElse: () => BusConnection([], 0.0, ''),
                        );

                        // Ensure we have valid stops
                        if (selectedConnection.stops.isNotEmpty) {
                          final busDirection =
                              '${selectedConnection.stops.first} - ${selectedConnection.stops.last}';

                          // Generate a random number of arrival times (between 1 to 3)
                          final random = Random();
                          final arrivalCount = random.nextInt(3) + 1; // Between 1 and 3

                          // Generate unique random arrival times (1 to 15 minutes), then sort
                          final randomArrivalTimes = List.generate(
                            arrivalCount,
                                (_) => random.nextInt(15) + 1, // Random times between 1 and 15 minutes
                          )..sort(); // Sort from least to greatest

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultPage(
                                busLine: selectedBusLine,
                                busDirection: busDirection,
                                arrivalTimes: randomArrivalTimes, // Pass the sorted list of arrival times
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            errorMessage = 'မရှိသော ကားလိုင်းဖြစ်ပါသည်';
                          });
                        }
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      elevation: 4,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ကြည့်မည်',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "PuPu",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Text(
                    'ရှာထားသော ကားချိန်များ',
                    style: TextStyle(fontSize: 16, fontFamily: "PuPu", fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'လတ်တလောမရှိပါ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontFamily: "PuPu",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}