// // // // // // ignore_for_file: file_names

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:lansio/Controller/LoginPageController.dart';
// // // // // import 'package:lansio/View/BottomNavBar.dart';
// // // // // import 'package:lansio/View/Contractor/Contractor_Bottom_Navigation.dart';
// // // // // import 'package:lansio/View/LoginPage.dart';
// // // // // import 'package:lansio/View/Worker/Worker_Bottom_Navigation.dart';
// // // // // import 'package:lansio/View/onboardingPage.dart';

// // // // // class Splashscreen extends StatefulWidget {
// // // // //   const Splashscreen({super.key});

// // // // //   @override
// // // // //   State<Splashscreen> createState() => _SplashscreenState();
// // // // // }

// // // // // class _SplashscreenState extends State<Splashscreen> {
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     navigateToScreen();
// // // // //   }

// // // // //   void navigateToScreen() async {
// // // // //     await Future.delayed(const Duration(seconds: 0));

// // // // //     final firebaseUser = FirebaseAuth.instance.currentUser;
// // // // //     Logincontroller logincontrollerobj = Logincontroller();
// // // // //     await logincontrollerobj.getSharedPrefData();

// // // // //     if (!logincontrollerobj.isOnboardingSeen) {
// // // // //       Navigator.of(context).pushReplacement(
// // // // //         MaterialPageRoute(builder: (context) => OnboardingPage()),
// // // // //       );
// // // // //       return;
// // // // //     }

// // // // //     if (firebaseUser == null) {
// // // // //       logincontrollerobj.clearSharedPref(); // Clear stale data
// // // // //       Navigator.of(
// // // // //         context,
// // // // //       ).pushReplacement(MaterialPageRoute(builder: (context) => Loginpage()));
// // // // //       return;
// // // // //     }

// // // // //     String? accountType;
// // // // //     final uid = firebaseUser.uid;
// // // // //     for (String col in ['users', 'contractors', 'workers']) {
// // // // //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
// // // // //           .collection(col)
// // // // //           .doc(uid)
// // // // //           .get();
// // // // //       if (userDoc.exists) {
// // // // //         accountType = userDoc.get('accountType');
// // // // //         break;
// // // // //       }
// // // // //     }

// // // // //     if (accountType == null) {
// // // // //       logincontrollerobj.clearSharedPref();
// // // // //       Navigator.of(
// // // // //         context,
// // // // //       ).pushReplacement(MaterialPageRoute(builder: (context) => Loginpage()));
// // // // //       return;
// // // // //     }

// // // // //     await logincontrollerobj.setSharedPrefData({
// // // // //       'email': logincontrollerobj.email,
// // // // //       'password': logincontrollerobj.password,
// // // // //       'loginflag': true,
// // // // //       'seenOnboarding': true,
// // // // //       'accountType': accountType,
// // // // //     });

// // // // //     if (accountType == 'User Account') {
// // // // //       Navigator.of(context).pushReplacement(
// // // // //         MaterialPageRoute(builder: (context) => const BottomNavBar()),
// // // // //       );
// // // // //     } else if (accountType == 'Contractor Account') {
// // // // //       Navigator.of(context).pushReplacement(
// // // // //         MaterialPageRoute(builder: (context) => ContractorBottomNavigation()),
// // // // //       );
// // // // //     } else if (accountType == 'Worker Account') {
// // // // //       Navigator.of(context).pushReplacement(
// // // // //         MaterialPageRoute(builder: (context) => WorkerBottomNavigation()),
// // // // //       );
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.greenAccent,
// // // // //       body: Center(
// // // // //         child: Column(
// // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // //           children: [
// // // // //             Image.asset("assets/logo.png", width: 120, height: 120),
// // // // //             const SizedBox(height: 20),
// // // // //             const Text(
// // // // //               "Welcome to Lansio",
// // // // //               style: TextStyle(
// // // // //                 fontSize: 24,
// // // // //                 fontWeight: FontWeight.bold,
// // // // //                 color: Colors.white,
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }








// // // // import 'package:flutter/material.dart';
// // // // import 'dart:async';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:lansio/Controller/LoginPageController.dart';
// // // // import 'package:lansio/View/BottomNavBar.dart';
// // // // import 'package:lansio/View/Contractor/Contractor_Bottom_Navigation.dart';
// // // // import 'package:lansio/View/LoginPage.dart';
// // // // import 'package:lansio/View/Worker/Worker_Bottom_Navigation.dart';
// // // // import 'package:lansio/View/onboardingPage.dart';

// // // // class Splashscreen extends StatefulWidget {
// // // //   const Splashscreen({super.key});

// // // //   @override
// // // //   State<Splashscreen> createState() => _SplashscreenState();
// // // // }

// // // // class _SplashscreenState extends State<Splashscreen>
// // // //     with TickerProviderStateMixin {
// // // //   late AnimationController _logoController;
// // // //   late Animation<double> _logoFade;
// // // //   late Animation<double> _logoScale;

// // // //   late List<AnimationController> _letterControllers;
// // // //   late List<Animation<Offset>> _letterAnimations;
// // // //   final String _appTitle = "Lansio";

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     // Logo animation
// // // //     _logoController = AnimationController(
// // // //       vsync: this,
// // // //       duration: const Duration(milliseconds: 60000),
// // // //     );
// // // //     _logoFade = CurvedAnimation(
// // // //       parent: _logoController,
// // // //       curve: Curves.easeOut,
// // // //     );
// // // //     _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
// // // //       CurvedAnimation(
// // // //         parent: _logoController,
// // // //         curve: Curves.elasticOut,
// // // //       ),
// // // //     );
// // // //     _logoController.forward();

// // // //     // Animated title
// // // //     _letterControllers = List.generate(_appTitle.length, (index) {
// // // //       return AnimationController(
// // // //         vsync: this,
// // // //         duration: const Duration(milliseconds: 380),
// // // //       );
// // // //     });
// // // //     _letterAnimations = List.generate(_appTitle.length, (index) {
// // // //       return Tween<Offset>(
// // // //         begin: const Offset(0, 2),
// // // //         end: Offset.zero,
// // // //       ).animate(CurvedAnimation(
// // // //         parent: _letterControllers[index],
// // // //         curve: Curves.easeOutBack,
// // // //       ));
// // // //     });
// // // //     _animateTitleLetters();

// // // //     // Handle navigation logic
// // // //     navigateToScreen();
// // // //   }

// // // //   void _animateTitleLetters() async {
// // // //     for (int i = 0; i < _appTitle.length; i++) {
// // // //       _letterControllers[i].forward();
// // // //       await Future.delayed(const Duration(milliseconds: 120));
// // // //     }
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _logoController.dispose();
// // // //     for (var controller in _letterControllers) {
// // // //       controller.dispose();
// // // //     }
// // // //     super.dispose();
// // // //   }

// // // //   void navigateToScreen() async {
// // // //     await Future.delayed(const Duration(seconds: 1));

// // // //     final firebaseUser = FirebaseAuth.instance.currentUser;
// // // //     Logincontroller logincontrollerobj = Logincontroller();
// // // //     await logincontrollerobj.getSharedPrefData();

// // // //     if (!logincontrollerobj.isOnboardingSeen) {
// // // //       Navigator.of(context).pushReplacement(
// // // //         MaterialPageRoute(builder: (context) => OnboardingPage()),
// // // //       );
// // // //       return;
// // // //     }

// // // //     if (firebaseUser == null) {
// // // //       logincontrollerobj.clearSharedPref();
// // // //       Navigator.of(context).pushReplacement(
// // // //         MaterialPageRoute(builder: (context) => Loginpage()),
// // // //       );
// // // //       return;
// // // //     }

// // // //     String? accountType;
// // // //     final uid = firebaseUser.uid;
// // // //     for (String col in ['users', 'contractors', 'workers']) {
// // // //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
// // // //           .collection(col)
// // // //           .doc(uid)
// // // //           .get();
// // // //       if (userDoc.exists) {
// // // //         accountType = userDoc.get('accountType');
// // // //         break;
// // // //       }
// // // //     }

// // // //     if (accountType == null) {
// // // //       logincontrollerobj.clearSharedPref();
// // // //       Navigator.of(context).pushReplacement(
// // // //         MaterialPageRoute(builder: (context) => Loginpage()),
// // // //       );
// // // //       return;
// // // //     }

// // // //     await logincontrollerobj.setSharedPrefData({
// // // //       'email': logincontrollerobj.email,
// // // //       'password': logincontrollerobj.password,
// // // //       'loginflag': true,
// // // //       'seenOnboarding': true,
// // // //       'accountType': accountType,
// // // //     });

// // // //     if (accountType == 'User Account') {
// // // //       Navigator.of(context).pushReplacement(
// // // //         MaterialPageRoute(builder: (context) => const BottomNavBar()),
// // // //       );
// // // //     } else if (accountType == 'Contractor Account') {
// // // //       Navigator.of(context).pushReplacement(
// // // //         MaterialPageRoute(builder: (context) => ContractorBottomNavigation()),
// // // //       );
// // // //     } else if (accountType == 'Worker Account') {
// // // //       Navigator.of(context).pushReplacement(
// // // //         MaterialPageRoute(builder: (context) => WorkerBottomNavigation()),
// // // //       );
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       body: Container(
// // // //         width: double.infinity,
// // // //         height: double.infinity,
// // // //         decoration: const BoxDecoration(
// // // //           gradient: LinearGradient(
// // // //             colors: [
// // // //               Color(0xFF187709),
// // // //               Color(0xFF3CCB75),
// // // //               Color(0xFFB3FFCB)
// // // //             ],
// // // //             begin: Alignment.topLeft,
// // // //             end: Alignment.bottomRight,
// // // //           ),
// // // //         ),
// // // //         child: Center(
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               ScaleTransition(
// // // //                 scale: _logoScale,
// // // //                 child: FadeTransition(
// // // //                   opacity: _logoFade,
// // // //                   child: Container(
// // // //                     width: 120,
// // // //                     height: 120,
// // // //                     decoration: BoxDecoration(
// // // //                       boxShadow: [
// // // //                         BoxShadow(
// // // //                           color: Colors.green.withOpacity(0.28),
// // // //                           blurRadius: 28,
// // // //                           spreadRadius: 2,
// // // //                           offset: const Offset(0, 12),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                     child: Image.asset(
// // // //                       "assets/logo.png",
// // // //                       fit: BoxFit.contain,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 30),
// // // //               // Lansio animated letters!
// // // //               Row(
// // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // //                 children: List.generate(_appTitle.length, (i) {
// // // //                   return SlideTransition(
// // // //                     position: _letterAnimations[i],
// // // //                     child: Text(
// // // //                       _appTitle[i],
// // // //                       style: const TextStyle(
// // // //                         fontSize: 40,
// // // //                         fontWeight: FontWeight.bold,
// // // //                         color: Colors.white,
// // // //                         shadows: [
// // // //                           Shadow(
// // // //                             blurRadius: 24,
// // // //                             color: Colors.green,
// // // //                             offset: Offset(0, 6),
// // // //                           ),
// // // //                           Shadow(
// // // //                             blurRadius: 10,
// // // //                             color: Color(0x8831ff70),
// // // //                             offset: Offset(0, 2),
// // // //                           ),
// // // //                         ],
// // // //                         letterSpacing: 2,
// // // //                       ),
// // // //                     ),
// // // //                   );
// // // //                 }),
// // // //               ),
// // // //               const SizedBox(height: 22),
// // // //               const Text(
// // // //                 "Welcome to Lansio",
// // // //                 style: TextStyle(
// // // //                   fontSize: 20,
// // // //                   letterSpacing: 1,
// // // //                   fontWeight: FontWeight.w600,
// // // //                   color: Colors.white,
// // // //                   shadows: [
// // // //                     Shadow(
// // // //                       blurRadius: 12,
// // // //                       color: Colors.green,
// // // //                       offset: Offset(0, 3),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }




// // // // ignore_for_file: file_names

// // // import 'package:flutter/material.dart';
// // // import 'dart:async';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:lansio/Controller/LoginPageController.dart';
// // // import 'package:lansio/View/BottomNavBar.dart';
// // // import 'package:lansio/View/Contractor/Contractor_Bottom_Navigation.dart';
// // // import 'package:lansio/View/LoginPage.dart';
// // // import 'package:lansio/View/Worker/Worker_Bottom_Navigation.dart';
// // // import 'package:lansio/View/onboardingPage.dart';

// // // class Splashscreen extends StatefulWidget {
// // //   const Splashscreen({super.key});

// // //   @override
// // //   State<Splashscreen> createState() => _SplashscreenState();
// // // }

// // // class _SplashscreenState extends State<Splashscreen>
// // //     with TickerProviderStateMixin {
// // //   late AnimationController _logoController;
// // //   late Animation<double> _logoFade;
// // //   late Animation<double> _logoScale;

// // //   late List<AnimationController> _letterControllers;
// // //   late List<Animation<Offset>> _letterAnimations;
// // //   final String _appTitle = "Lansio";

// // //   late List<AnimationController> _taglineControllers;
// // //   late List<Animation<double>> _taglineFade;
// // //   final List<String> _taglineWords = ["Build", "Connect", "Grow"];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // Logo animation
// // //     _logoController = AnimationController(
// // //       vsync: this,
// // //       duration: const Duration(milliseconds: 1800),
// // //     );
// // //     _logoFade = CurvedAnimation(
// // //       parent: _logoController,
// // //       curve: Curves.easeIn,
// // //     );
// // //     _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _logoController,
// // //         curve: Curves.elasticOut,
// // //       ),
// // //     );
// // //     _logoController.forward();

// // //     // Animated title
// // //     _letterControllers = List.generate(_appTitle.length, (index) {
// // //       return AnimationController(
// // //         vsync: this,
// // //         duration: const Duration(milliseconds: 620),
// // //       );
// // //     });
// // //     _letterAnimations = List.generate(_appTitle.length, (index) {
// // //       return Tween<Offset>(
// // //         begin: const Offset(0, 2),
// // //         end: Offset.zero,
// // //       ).animate(CurvedAnimation(
// // //         parent: _letterControllers[index],
// // //         curve: Curves.easeOutBack,
// // //       ));
// // //     });
// // //     _animateTitleLetters();

// // //     // Tagline animations
// // //     _taglineControllers = List.generate(_taglineWords.length, (index) {
// // //       return AnimationController(
// // //         vsync: this,
// // //         duration: const Duration(milliseconds: 650),
// // //       );
// // //     });
// // //     _taglineFade = List.generate(_taglineWords.length, (i) {
// // //       return CurvedAnimation(
// // //         parent: _taglineControllers[i],
// // //         curve: Curves.easeIn,
// // //       );
// // //     });
// // //     _animateTagline();

// // //     // Navigation
// // //     navigateToScreen();
// // //   }

// // //   Future<void> _animateTitleLetters() async {
// // //     for (int i = 0; i < _appTitle.length; i++) {
// // //       _letterControllers[i].forward();
// // //       await Future.delayed(const Duration(milliseconds: 200));
// // //     }
// // //   }

// // //   Future<void> _animateTagline() async {
// // //     for (int i = 0; i < _taglineWords.length; i++) {
// // //       await Future.delayed(const Duration(milliseconds: 260));
// // //       _taglineControllers[i].forward();
// // //     }
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _logoController.dispose();
// // //     for (var controller in _letterControllers) {
// // //       controller.dispose();
// // //     }
// // //     for (var controller in _taglineControllers) {
// // //       controller.dispose();
// // //     }
// // //     super.dispose();
// // //   }

// // //   void navigateToScreen() async {
// // //     await Future.delayed(const Duration(seconds: 1));
// // //     final firebaseUser = FirebaseAuth.instance.currentUser;
// // //     Logincontroller logincontrollerobj = Logincontroller();
// // //     await logincontrollerobj.getSharedPrefData();

// // //     if (!logincontrollerobj.isOnboardingSeen) {
// // //       Navigator.of(context).pushReplacement(
// // //         MaterialPageRoute(builder: (context) => OnboardingPage()),
// // //       );
// // //       return;
// // //     }
// // //     if (firebaseUser == null) {
// // //       logincontrollerobj.clearSharedPref();
// // //       Navigator.of(context).pushReplacement(
// // //         MaterialPageRoute(builder: (context) => Loginpage()),
// // //       );
// // //       return;
// // //     }

// // //     String? accountType;
// // //     final uid = firebaseUser.uid;
// // //     for (String col in ['users', 'contractors', 'workers']) {
// // //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
// // //           .collection(col)
// // //           .doc(uid)
// // //           .get();
// // //       if (userDoc.exists) {
// // //         accountType = userDoc.get('accountType');
// // //         break;
// // //       }
// // //     }

// // //     if (accountType == null) {
// // //       logincontrollerobj.clearSharedPref();
// // //       Navigator.of(context).pushReplacement(
// // //         MaterialPageRoute(builder: (context) => Loginpage()),
// // //       );
// // //       return;
// // //     }

// // //     await logincontrollerobj.setSharedPrefData({
// // //       'email': logincontrollerobj.email,
// // //       'password': logincontrollerobj.password,
// // //       'loginflag': true,
// // //       'seenOnboarding': true,
// // //       'accountType': accountType,
// // //     });

// // //     if (accountType == 'User Account') {
// // //       Navigator.of(context).pushReplacement(
// // //         MaterialPageRoute(builder: (context) => const BottomNavBar()),
// // //       );
// // //     } else if (accountType == 'Contractor Account') {
// // //       Navigator.of(context).pushReplacement(
// // //         MaterialPageRoute(builder: (context) => ContractorBottomNavigation()),
// // //       );
// // //     } else if (accountType == 'Worker Account') {
// // //       Navigator.of(context).pushReplacement(
// // //         MaterialPageRoute(builder: (context) => WorkerBottomNavigation()),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Container(
// // //         width: double.infinity,
// // //         height: double.infinity,
// // //         decoration: const BoxDecoration(
// // //           gradient: LinearGradient(
// // //             colors: [
// // //               Color(0xFFa8e063),
// // //               Color(0xFF56ab2f),
// // //             ],
// // //             begin: Alignment.topCenter,
// // //             end: Alignment.bottomCenter,
// // //           ),
// // //         ),
// // //         child: Center(
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               // Animated Lansio letters
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: List.generate(_appTitle.length, (i) {
// // //                   return SlideTransition(
// // //                     position: _letterAnimations[i],
// // //                     child: Text(
// // //                       _appTitle[i],
// // //                       style: const TextStyle(
// // //                         fontSize: 48,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Colors.white,
// // //                         letterSpacing: 2,
// // //                         shadows: [
// // //                           Shadow(
// // //                             blurRadius: 12,
// // //                             color: Color(0x9956ab2f),
// // //                             offset: Offset(0, 5),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   );
// // //                 }),
// // //               ),
// // //               const SizedBox(height: 8),
// // //               // Animated logo in the middle
// // //               ScaleTransition(
// // //                 scale: _logoScale,
// // //                 child: FadeTransition(
// // //                   opacity: _logoFade,
// // //                   child: Container(
// // //                     width: 120,
// // //                     height: 120,
// // //                     decoration: BoxDecoration(
// // //                       shape: BoxShape.circle,
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                           color: Colors.white.withOpacity(0.09),
// // //                           blurRadius: 38,
// // //                           offset: const Offset(0, 10),
// // //                         ),
// // //                         BoxShadow(
// // //                           color: Colors.green.withOpacity(0.26),
// // //                           blurRadius: 14,
// // //                           spreadRadius: 3,
// // //                           offset: const Offset(0, 10),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     child: Image.asset(
// // //                       "assets/logo.png",
// // //                       fit: BoxFit.contain,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 14),
// // //               // Animated tagline: Build Connect Grow
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: List.generate(_taglineWords.length, (i) {
// // //                   return FadeTransition(
// // //                     opacity: _taglineFade[i],
// // //                     child: Padding(
// // //                       padding: EdgeInsets.symmetric(horizontal: 10),
// // //                       child: Text(
// // //                         _taglineWords[i],
// // //                         style: TextStyle(
// // //                           fontSize: 21,
// // //                           fontWeight: FontWeight.w700,
// // //                           color: Colors.white,
// // //                           letterSpacing: 1,
// // //                           shadows: [
// // //                             Shadow(
// // //                               blurRadius: 12,
// // //                               color: Colors.green.shade800,
// // //                               offset: Offset(0, 3),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   );
// // //                 }),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }







// // // ignore_for_file: file_names

// // import 'package:flutter/material.dart';
// // import 'dart:async';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:lansio/Controller/LoginPageController.dart';
// // import 'package:lansio/View/BottomNavBar.dart';
// // import 'package:lansio/View/Contractor/Contractor_Bottom_Navigation.dart';
// // import 'package:lansio/View/LoginPage.dart';
// // import 'package:lansio/View/Worker/Worker_Bottom_Navigation.dart';
// // import 'package:lansio/View/onboardingPage.dart';

// // class Splashscreen extends StatefulWidget {
// //   const Splashscreen({super.key});

// //   @override
// //   State<Splashscreen> createState() => _SplashscreenState();
// // }

// // class _SplashscreenState extends State<Splashscreen> with TickerProviderStateMixin {
// //   late AnimationController _logoController;
// //   late Animation<double> _logoFade;
// //   late Animation<double> _logoScale;

// //   late List<AnimationController> _letterControllers;
// //   late List<Animation<Offset>> _letterAnimations;
// //   final String _appTitle = "Lansio";

// //   late List<AnimationController> _taglineControllers;
// //   late List<Animation<double>> _taglineFade;
// //   final List<String> _taglineWords = ["Build", "Connect", "Grow"];

// //   @override
// //   void initState() {
// //     super.initState();

// //     // Logo animation
// //     _logoController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 1800),
// //     );
// //     _logoFade = CurvedAnimation(
// //       parent: _logoController,
// //       curve: Curves.easeIn,
// //     );
// //     _logoScale = Tween<double>(begin: 0.55, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _logoController,
// //         curve: Curves.elasticOut,
// //       ),
// //     );
// //     _logoController.forward();

// //     // Title letter animation
// //     _letterControllers = List.generate(_appTitle.length, (index) {
// //       return AnimationController(
// //         vsync: this,
// //         duration: const Duration(milliseconds: 600),
// //       );
// //     });
// //     _letterAnimations = List.generate(_appTitle.length, (index) {
// //       return Tween<Offset>(
// //         begin: const Offset(0, 2),
// //         end: Offset.zero,
// //       ).animate(CurvedAnimation(
// //         parent: _letterControllers[index],
// //         curve: Curves.easeOutBack,
// //       ));
// //     });

// //     // Tagline word animations
// //     _taglineControllers = List.generate(_taglineWords.length, (index) {
// //       return AnimationController(
// //         vsync: this,
// //         duration: const Duration(milliseconds: 700),
// //       );
// //     });
// //     _taglineFade = List.generate(_taglineWords.length, (i) {
// //       return CurvedAnimation(
// //         parent: _taglineControllers[i],
// //         curve: Curves.easeIn,
// //       );
// //     });

// //     // Run splash animations before navigating away
// //     _runFullSplashAnimation();
// //   }

// //   Future<void> _runFullSplashAnimation() async {
// //     // Logo animates in first (very quick)
// //     await _logoController.forward();

// //     // Animate title letter by letter
// //     for (int i = 0; i < _appTitle.length; i++) {
// //       await _letterControllers[i].forward();
// //       await Future.delayed(const Duration(milliseconds: 180));
// //     }

// //     // Animate tagline words one by one
// //     for (int i = 0; i < _taglineWords.length; i++) {
// //       await _taglineControllers[i].forward();
// //       await Future.delayed(const Duration(milliseconds: 330));
// //     }

// //     // After everything is animating, wait briefly then navigate
// //     await Future.delayed(const Duration(milliseconds: 600));
// //     navigateToScreen();
// //   }

// //   @override
// //   void dispose() {
// //     _logoController.dispose();
// //     for (var controller in _letterControllers) {
// //       controller.dispose();
// //     }
// //     for (var controller in _taglineControllers) {
// //       controller.dispose();
// //     }
// //     super.dispose();
// //   }

// //   void navigateToScreen() async {
// //     // Your existing navigation logic
// //     final firebaseUser = FirebaseAuth.instance.currentUser;
// //     Logincontroller logincontrollerobj = Logincontroller();
// //     await logincontrollerobj.getSharedPrefData();

// //     if (!logincontrollerobj.isOnboardingSeen) {
// //       Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(builder: (context) => OnboardingPage()),
// //       );
// //       return;
// //     }
// //     if (firebaseUser == null) {
// //       logincontrollerobj.clearSharedPref();
// //       Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(builder: (context) => Loginpage()),
// //       );
// //       return;
// //     }

// //     String? accountType;
// //     final uid = firebaseUser.uid;
// //     for (String col in ['users', 'contractors', 'workers']) {
// //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
// //           .collection(col)
// //           .doc(uid)
// //           .get();
// //       if (userDoc.exists) {
// //         accountType = userDoc.get('accountType');
// //         break;
// //       }
// //     }

// //     if (accountType == null) {
// //       logincontrollerobj.clearSharedPref();
// //       Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(builder: (context) => Loginpage()),
// //       );
// //       return;
// //     }

// //     await logincontrollerobj.setSharedPrefData({
// //       'email': logincontrollerobj.email,
// //       'password': logincontrollerobj.password,
// //       'loginflag': true,
// //       'seenOnboarding': true,
// //       'accountType': accountType,
// //     });

// //     if (accountType == 'User Account') {
// //       Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(builder: (context) => const BottomNavBar()),
// //       );
// //     } else if (accountType == 'Contractor Account') {
// //       Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(builder: (context) => ContractorBottomNavigation()),
// //       );
// //     } else if (accountType == 'Worker Account') {
// //       Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(builder: (context) => WorkerBottomNavigation()),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         width: double.infinity,
// //         height: double.infinity,
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               Color(0xFFa8e063),
// //               Color(0xFF56ab2f),
// //             ],
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //           ),
// //         ),
// //         child: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               // Animated Lansio letters
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: List.generate(_appTitle.length, (i) {
// //                   return SlideTransition(
// //                     position: _letterAnimations[i],
// //                     child: Text(
// //                       _appTitle[i],
// //                       style: const TextStyle(
// //                         fontSize: 48,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.white,
// //                         letterSpacing: 2,
// //                         shadows: [
// //                           Shadow(
// //                             blurRadius: 18,
// //                             color: Color(0x9956ab2f),
// //                             offset: Offset(0, 5),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 }),
// //               ),
// //               const SizedBox(height: 18),
// //               // Animated logo in the middle
// //               ScaleTransition(
// //                 scale: _logoScale,
// //                 child: FadeTransition(
// //                   opacity: _logoFade,
// //                   child: Container(
// //                     width: 200,
// //                     height: 200,
// //                     decoration: BoxDecoration(
// //                       shape: BoxShape.circle,
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.white.withOpacity(0.09),
// //                           blurRadius: 38,
// //                           offset: const Offset(0, 10),
// //                         ),
// //                         BoxShadow(
// //                           color: Colors.green.withOpacity(0.22),
// //                           blurRadius: 22,
// //                           spreadRadius: 2,
// //                           offset: const Offset(0, 12),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Image.asset(
// //                       "assets/logo.png",
// //                       fit: BoxFit.contain,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               // Animated tagline: Build Connect Grow
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: List.generate(_taglineWords.length, (i) {
// //                   return FadeTransition(
// //                     opacity: _taglineFade[i],
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 15),
// //                       child: Text(
// //                         _taglineWords[i],
// //                         style: TextStyle(
// //                           fontSize: 25,
// //                           fontWeight: FontWeight.w700,
// //                           color: Colors.white,
// //                           letterSpacing: 1,
// //                           shadows: [
// //                             Shadow(
// //                               blurRadius: 14,
// //                               color: Colors.green.shade800,
// //                               offset: Offset(0, 3),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 }),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }




// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lansio/Controller/LoginPageController.dart';
// import 'package:lansio/View/BottomNavBar.dart';
// import 'package:lansio/View/Contractor/Contractor_Bottom_Navigation.dart';
// import 'package:lansio/View/LoginPage.dart';
// import 'package:lansio/View/Worker/Worker_Bottom_Navigation.dart';
// import 'package:lansio/View/onboardingPage.dart';

// class Splashscreen extends StatefulWidget {
//   const Splashscreen({super.key});

//   @override
//   State<Splashscreen> createState() => _SplashscreenState();
// }

// class _SplashscreenState extends State<Splashscreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late Animation<double> _logoFade;
//   late Animation<double> _logoScale;

//   late List<AnimationController> _letterControllers;
//   late List<Animation<Offset>> _letterAnimations;
//   final String _appTitle = "Lansio";

//   late List<AnimationController> _taglineControllers;
//   late List<Animation<double>> _taglineFade;
//   final List<String> _taglineWords = ["Build", "Connect", "Grow"];

//   @override
//   void initState() {
//     super.initState();

//     // Logo animation
//     _logoController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     );
//     _logoFade = CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.easeIn,
//     );
//     _logoScale = Tween<double>(begin: 0.48, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _logoController,
//         curve: Curves.elasticOut,
//       ),
//     );
//     _logoController.forward();

//     // Title letter animation
//     _letterControllers = List.generate(_appTitle.length, (index) {
//       return AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 600),
//       );
//     });
//     _letterAnimations = List.generate(_appTitle.length, (index) {
//       return Tween<Offset>(
//         begin: const Offset(0, 2),
//         end: Offset.zero,
//       ).animate(CurvedAnimation(
//         parent: _letterControllers[index],
//         curve: Curves.easeOutBack,
//       ));
//     });

//     // Tagline word animations
//     _taglineControllers = List.generate(_taglineWords.length, (index) {
//       return AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 700),
//       );
//     });
//     _taglineFade = List.generate(_taglineWords.length, (i) {
//       return CurvedAnimation(
//         parent: _taglineControllers[i],
//         curve: Curves.easeIn,
//       );
//     });

//     // Run splash animations before navigating away
//     _runFullSplashAnimation();
//   }

//   Future<void> _runFullSplashAnimation() async {
//     await _logoController.forward();

//     for (int i = 0; i < _appTitle.length; i++) {
//       await _letterControllers[i].forward();
//       await Future.delayed(const Duration(milliseconds: 180));
//     }

//     for (int i = 0; i < _taglineWords.length; i++) {
//       await _taglineControllers[i].forward();
//       await Future.delayed(const Duration(milliseconds: 330));
//     }

//     await Future.delayed(const Duration(milliseconds: 600));
//     navigateToScreen();
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     for (var controller in _letterControllers) {
//       controller.dispose();
//     }
//     for (var controller in _taglineControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   void navigateToScreen() async {
//     final firebaseUser = FirebaseAuth.instance.currentUser;
//     Logincontroller logincontrollerobj = Logincontroller();
//     await logincontrollerobj.getSharedPrefData();

//     if (!logincontrollerobj.isOnboardingSeen) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => OnboardingPage()),
//       );
//       return;
//     }
//     if (firebaseUser == null) {
//       logincontrollerobj.clearSharedPref();
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => Loginpage()),
//       );
//       return;
//     }

//     String? accountType;
//     final uid = firebaseUser.uid;
//     for (String col in ['users', 'contractors', 'workers']) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection(col)
//           .doc(uid)
//           .get();
//       if (userDoc.exists) {
//         accountType = userDoc.get('accountType');
//         break;
//       }
//     }

//     if (accountType == null) {
//       logincontrollerobj.clearSharedPref();
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => Loginpage()),
//       );
//       return;
//     }

//     await logincontrollerobj.setSharedPrefData({
//       'email': logincontrollerobj.email,
//       'password': logincontrollerobj.password,
//       'loginflag': true,
//       'seenOnboarding': true,
//       'accountType': accountType,
//     });

//     if (accountType == 'User Account') {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const BottomNavBar()),
//       );
//     } else if (accountType == 'Contractor Account') {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => ContractorBottomNavigation()),
//       );
//     } else if (accountType == 'Worker Account') {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => WorkerBottomNavigation()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Gradient for text
//     final Shader nameShader = LinearGradient(
//       colors: <Color>[
//         Color(0xFFffffff),
//         Color(0xFFa8e063),
//         Color(0xFF56ab2f),
//         Color(0xFF11630a),
//       ],
//       stops: const [0, 0.3, 0.7, 1],
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     ).createShader(const Rect.fromLTWH(0.0, 0.0, 320.0, 90.0));

//     final List<Color> wordColors = [
//       Colors.greenAccent.shade100,
//       Colors.greenAccent.shade400,
//       Colors.lightGreenAccent.shade700,
//     ];

//     final List<TextStyle> wordStyles = List.generate(
//       _taglineWords.length,
//       (i) => GoogleFonts.poppins(
//         color: wordColors[i],
//         fontWeight: FontWeight.bold,
//         fontSize: 33,
//         letterSpacing: 1.7,
//         shadows: [
//           Shadow(
//             blurRadius: 12,
//             color: Colors.black26,
//             offset: Offset(0, 3),
//           )
//         ],
//       ),
//     );

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 187, 236, 127),
//               Color.fromARGB(255, 62, 116, 37),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Animated Lansio letters
//             // Inside the build method, replace title Row with this: 

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: List.generate(_appTitle.length, (i) {
//     return SlideTransition(
//       position: _letterAnimations[i],
//       child: Text(
//         _appTitle[i],
//         style: GoogleFonts.montserrat(
//           fontSize: 60,
//           fontWeight: FontWeight.w900,
//           letterSpacing: 4,
//           color: const Color.fromARGB(255, 48, 90, 48),  // dark green shade
//           shadows: [
//             Shadow(
//               blurRadius: 18,
//               color: Colors.black45,
//               offset: Offset(0, 5),
//             ),
//           ],
//         ),
//       ),
//     );
//   }),
// ),

//               const SizedBox(height: 24),
//               // Animated logo in the middle
//               ScaleTransition(
//                 scale: _logoScale,
//                 child: FadeTransition(
//                   opacity: _logoFade,
//                   child: Container(
//                     width: 270,
//                     height: 270,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.white.withOpacity(0.09),
//                           blurRadius: 66,
//                           offset: const Offset(0, 25),
//                         ),
//                         BoxShadow(
//                           color: Colors.green.withOpacity(0.24),
//                           blurRadius: 34,
//                           spreadRadius: 3,
//                           offset: const Offset(0, 20),
//                         ),
//                       ],
//                     ),
//                     child: Image.asset(
//                       "assets/logo.png",
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               // Animated tagline: Build Connect Grow
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(_taglineWords.length, (i) {
//                   return FadeTransition(
//                     opacity: _taglineFade[i],
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 18),
//                       child: Text(
//                         _taglineWords[i],
//                         style: wordStyles[i],
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }







// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lansio/Controller/LoginPageController.dart';
import 'package:lansio/View/BottomNavBar.dart';
import 'package:lansio/View/Contractor/Contractor_Bottom_Navigation.dart';
import 'package:lansio/View/LoginPage.dart';
import 'package:lansio/View/Worker/Worker_Bottom_Navigation.dart';
import 'package:lansio/View/onboardingPage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoFade;
  late Animation<double> _logoScale;

  late List<AnimationController> _letterControllers;
  late List<Animation<Offset>> _letterAnimations;
  final String _appTitle = "Lansio";

  late List<AnimationController> _taglineControllers;
  late List<Animation<double>> _taglineFade;
  final List<String> _taglineWords = ["Build", "Connect"];

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _logoFade = CurvedAnimation(parent: _logoController, curve: Curves.easeIn);
    _logoScale = Tween<double>(begin: 0.48, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoController.forward();

    // Title letter animation
    _letterControllers = List.generate(_appTitle.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
    });
    _letterAnimations = List.generate(_appTitle.length, (index) {
      return Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _letterControllers[index],
          curve: Curves.easeOutBack,
        ),
      );
    });

    // Tagline word animations
    _taglineControllers = List.generate(_taglineWords.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700),
      );
    });
    _taglineFade = List.generate(_taglineWords.length, (i) {
      return CurvedAnimation(
        parent: _taglineControllers[i],
        curve: Curves.easeIn,
      );
    });

    // Run splash animations before navigating away
    _runFullSplashAnimation();
  }

  Future<void> _runFullSplashAnimation() async {
    await _logoController.forward();

    for (int i = 0; i < _appTitle.length; i++) {
      await _letterControllers[i].forward();
      await Future.delayed(const Duration(milliseconds: 180));
    }

    for (int i = 0; i < _taglineWords.length; i++) {
      await _taglineControllers[i].forward();
      await Future.delayed(const Duration(milliseconds: 330));
    }

    await Future.delayed(const Duration(milliseconds: 600));
    navigateToScreen();
  }

  @override
  void dispose() {
    _logoController.dispose();
    for (var controller in _letterControllers) {
      controller.dispose();
    }
    for (var controller in _taglineControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void navigateToScreen() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    Logincontroller logincontrollerobj = Logincontroller();
    await logincontrollerobj.getSharedPrefData();

    if (!logincontrollerobj.isOnboardingSeen) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
      return;
    }
    if (firebaseUser == null) {
      logincontrollerobj.clearSharedPref();
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Loginpage()));
      return;
    }

    String? accountType;
    final uid = firebaseUser.uid;
    for (String col in ['users', 'contractors', 'workers']) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(col)
          .doc(uid)
          .get();
      if (userDoc.exists) {
        accountType = userDoc.get('accountType');
        break;
      }
    }

    if (accountType == null) {
      logincontrollerobj.clearSharedPref();
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Loginpage()));
      return;
    }

    await logincontrollerobj.setSharedPrefData({
      'email': logincontrollerobj.email,
      'password': logincontrollerobj.password,
      'loginflag': true,
      'seenOnboarding': true,
      'accountType': accountType,
    });

    if (accountType == 'User Account') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    } else if (accountType == 'Contractor Account') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ContractorBottomNavigation()),
      );
    } else if (accountType == 'Worker Account') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WorkerBottomNavigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gradient for text
    final Shader nameShader = LinearGradient(
      colors: <Color>[
        Color(0xFFffffff),
        Color(0xFFa8e063),
        Color(0xFF56ab2f),
        Color(0xFF11630a),
      ],
      stops: const [0, 0.3, 0.7, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 320.0, 90.0));

    final List<Color> wordColors = [
      Colors.greenAccent.shade100,
      Colors.greenAccent.shade400,
      Colors.lightGreenAccent.shade700,
    ];

    final List<TextStyle> wordStyles = List.generate(
      _taglineWords.length,
      (i) => GoogleFonts.poppins(
        color: wordColors[i],
        fontWeight: FontWeight.bold,
        fontSize: 33,
        letterSpacing: 1.7,
        shadows: [
          Shadow(blurRadius: 12, color: Colors.black26, offset: Offset(0, 3)),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 187, 236, 127),
              Color.fromARGB(255, 62, 116, 37),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Lansio letters
              // Inside the build method, replace title Row with this:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_appTitle.length, (i) {
                  return SlideTransition(
                    position: _letterAnimations[i],
                    child: Text(
                      _appTitle[i],
                      style: GoogleFonts.montserrat(
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                        color: const Color.fromARGB(
                          255,
                          48,
                          90,
                          48,
                        ), // dark green shade
                        shadows: [
                          Shadow(
                            blurRadius: 18,
                            color: Colors.black45,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),
              // Animated logo in the middle
              ScaleTransition(
                scale: _logoScale,
                child: FadeTransition(
                  opacity: _logoFade,
                  child: Container(
                    width: 270,
                    height: 270,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.09),
                          blurRadius: 66,
                          offset: const Offset(0, 25),
                        ),
                        BoxShadow(
                          color: Colors.green.withOpacity(0.24),
                          blurRadius: 34,
                          spreadRadius: 3,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Image.asset("assets/logo.png", fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Animated tagline: Build Connect Grow
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_taglineWords.length, (i) {
                  return FadeTransition(
                    opacity: _taglineFade[i],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(_taglineWords[i], style: wordStyles[i]),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}