import 'package:flutter/material.dart';
import 'dart:async';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with TickerProviderStateMixin {
  // Animations for letters in title
  late List<AnimationController> _letterControllers;
  late List<Animation<Offset>> _letterAnimations;
  final String _title = "Welcome to Lansio!";

  // Animations for sections
  late AnimationController _aboutController;
  late Animation<double> _aboutFade;
  late AnimationController _missionController;
  late Animation<double> _missionFade;

  @override
  void initState() {
    super.initState();
    // Title letter animation setup
    _letterControllers = List.generate(_title.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 350),
      );
    });

    _letterAnimations = List.generate(_title.length, (index) {
      return Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _letterControllers[index],
          curve: Curves.easeOut,
        ),
      );
    });

    // Trigger letter animations one by one
    _animateTitleLetters();

    // About Section Animation
    _aboutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _aboutFade = CurvedAnimation(
      parent: _aboutController,
      curve: Curves.easeOut,
    );
    Timer(const Duration(milliseconds: 750), () {
      _aboutController.forward();
    });

    // Mission Section Animation
    _missionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _missionFade = CurvedAnimation(
      parent: _missionController,
      curve: Curves.easeOut,
    );
    Timer(const Duration(milliseconds: 1300), () {
      _missionController.forward();
    });
  }

  void _animateTitleLetters() {
    Future.forEach<int>(List.generate(_title.length, (i) => i), (i) async {
      _letterControllers[i].forward();
      await Future.delayed(const Duration(milliseconds: 80));
    });
  }

  @override
  void dispose() {
    for (var controller in _letterControllers) {
      controller.dispose();
    }
    _aboutController.dispose();
    _missionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Removed: teamMembers list

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🌿 Animated Gradient Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.lightGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_title.length, (i) {
                    return SlideTransition(
                      position: _letterAnimations[i],
                      child: Text(
                        _title[i],
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🧭 About the Project (Animated)
            FadeTransition(
              opacity: _aboutFade,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                color: Colors.white.withOpacity(0.98),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: const [
                      Text(
                        "About Our Project",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Lansio is a smart platform for easy landscaping teamwork. "
                        "Contractors and workers can connect, chat, and organize tasks quickly. "
                        "With Lansio, everyone stays updated and projects get done seamlessly.",
                        style: TextStyle(fontSize: 15, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 👩‍💻 Our Mission (Animated)
            FadeTransition(
              opacity: _missionFade,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                color: Colors.green[50],
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: const [
                      Text(
                        "Our Mission",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Lansio aims to make landscaping projects simple for all. "
                        "We empower teams to communicate easily and deliver top-quality work.",
                        style: TextStyle(fontSize: 15, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 💚 Special Thanks Section (Only Shashi Sir)
            Column(
              children: [
                const Text(
                  "💚 Special Thanks 💚",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/ShashiSir.png"),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Shashi Bagal Sir",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    "We extend our heartfelt gratitude to the entire Core2Web team for their constant guidance, mentorship, "
                    "and inspiration. Their real-world training, practical learning, and continuous support helped us transform "
                    "ideas into impactful projects like Lansio.",
                    style: TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Removed: Team Members Section (👥 Team Members Section and GridView.builder)
            // Final SizedBox is now reduced as the GridView is gone
            const SizedBox(height: 1),
          ],
        ),
      ),
    );
  }
}