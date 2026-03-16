// ignore_for_file: file_names

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lansio/Controller/LoginPageController.dart';
import 'package:lansio/View/LoginPage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  final introKey = GlobalKey<IntroductionScreenState>();
  int currentPage = 0;
  Timer? autoSlideTimer;

  late final AnimationController _imageController;
  late final Animation<Offset> _imageAnimation;

  @override
  void initState() {
    super.initState();

    // Image slide animation
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _imageAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));

    startAutoSlide();
  }

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to Lansio",
      "body":
          "Connect with landscapers, contractors, and workers effortlessly.",
      "image": "assets/onboarding1.png",
    },
    {
      "title": "Hire or Post Projects",
      "body": "Find reliable professionals or share your landscaping needs.",
      "image": "assets/onboarding2.webp",
    },
    {
      "title": "Grow Your Green Space",
      "body": "Collaborate and bring your outdoor vision to life.",
      "image": "assets/onboarding3.png",
    },
  ];

  void startAutoSlide() {
    autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (introKey.currentState != null &&
          currentPage < onboardingData.length - 1) {
        int nextPage = currentPage + 1;
        introKey.currentState!.animateScroll(nextPage);
        setState(() {
          currentPage = nextPage;
        });
      }
    });
  }

  Future<void> markOnboardingSeen() async {
    Logincontroller logincontrollerobj = Logincontroller();
    logincontrollerobj.setSharedPrefData({
      'email': '',
      'password': '',
      'loginflag': false,
      'seenOnboarding': true,
    });
  }

  void goToLogin() async {
    await markOnboardingSeen();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Loginpage()),
    );
  }

  @override
  void dispose() {
    autoSlideTimer?.cancel();
    _imageController.dispose();
    super.dispose();
  }

  List<PageViewModel> _buildPages() {
    return onboardingData.map((data) {
      _imageController.forward(from: 0); // restart animation
      return PageViewModel(
        title: data['title']!,
        body: data['body']!,
        image: SlideTransition(
          position: _imageAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(data['image']!, fit: BoxFit.contain),
          ),
        ),
        decoration: _pageDecoration(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Blur overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.white.withOpacity(0.15)),
          ),

          // Introduction pages
          SafeArea(
            child: IntroductionScreen(
              key: introKey,
              globalBackgroundColor: Colors.transparent,
              pages: _buildPages(),
              showSkipButton: true,
              skip: TextButton(
                onPressed: goToLogin,
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              next: const Icon(Icons.arrow_forward, color: Colors.white),
              done: const Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onDone: goToLogin,
              onChange: (index) {
                setState(() {
                  currentPage = index;
                  _imageController.forward(from: 0);
                });
              },
              dotsDecorator: DotsDecorator(
                size: const Size(10, 10),
                color: Colors.white.withOpacity(0.5),
                activeSize: const Size(22, 10),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                activeColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Page text decoration
PageDecoration _pageDecoration() {
  return const PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: [Shadow(color: Colors.black26, blurRadius: 5)],
    ),
    bodyTextStyle: TextStyle(fontSize: 18, color: Colors.white70, height: 1.5),
    imagePadding: EdgeInsets.only(top: 50),
    pageColor: Colors.transparent,
  );
}
