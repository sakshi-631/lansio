// import "package:firebase_core/firebase_core.dart";
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import "package:lansio/View/BottomNavBar.dart";
import "package:lansio/View/SplashScreen.dart";
import "package:lansio/View/LoginPage.dart";
import "package:lansio/View/aboutus_page.dart";
import "package:lansio/screens/gemini_ai_page.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDKcsdGEVr2c_n79XN9zcrW96RyQ3OINvw",
      appId: "1:967180854501:android:e0f72846ce9642023a200c",
      messagingSenderId: "967180854501",
      projectId: "lansio-c0991",
      storageBucket: "lansio-c0991.firebasestorage.app",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Splashscreen(), debugShowCheckedModeBanner: false);
  }
}
