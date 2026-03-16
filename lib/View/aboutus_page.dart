


// // import 'package:flutter/material.dart';

// // class AboutUsPage extends StatelessWidget {
// //   const AboutUsPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Team member data
// //     final List<Map<String, String>> teamMembers = [
// //       {
// //         "name": "Avishkar Jadhav",
// //         "mentor": "Shashi Bagal Sir",
// //         "image":
// //             "https://i.pravatar.cc/150?img=1" // placeholder profile image
// //       },
// //       {
// //         "name": "Aadesh Landage",
// //         "mentor": "Shashi Bagal Sir",
// //         "image": "https://i.pravatar.cc/150?img=2"
// //       },
// //       {
// //         "name": "Sakshi Sadgir",
// //         "mentor": "Shashi Bagal Sir",
// //         "image": "https://i.pravatar.cc/150?img=3"
// //       },
// //       {
// //         "name": "Nikita Sidankar",
// //         "mentor": "Shashi Bagal Sir",
// //         "image": "https://i.pravatar.cc/150?img=4"
// //       },
// //     ];

// //     return Scaffold(
// //       backgroundColor: Colors.grey[100],
// //       appBar: AppBar(
// //         title: const Text("About Us"),
// //         centerTitle: true,
// //         backgroundColor: Colors.deepPurple,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             // 🌈 Gradient Banner
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(20),
// //                 gradient: const LinearGradient(
// //                   colors: [Colors.deepPurple, Colors.purpleAccent],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //               ),
// //               child: const Text(
// //                 "Welcome to VybeRide!",
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: 26,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),

// //             const SizedBox(height: 20),

// //             // 🧭 About the Project
// //             Card(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //               elevation: 4,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(20),
// //                 child: Column(
// //                   children: const [
// //                     Text(
// //                       "About Our Project",
// //                       style: TextStyle(
// //                         fontSize: 22,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.deepPurple,
// //                       ),
// //                     ),
// //                     SizedBox(height: 10),
// //                     Text(
// //                       "VybeRide is an innovative ride-sharing platform designed to make commuting smooth, safe, and efficient. "
// //                       "Our app connects riders and drivers seamlessly, providing a simple, modern, and eco-friendly way to travel.",
// //                       style: TextStyle(fontSize: 16, height: 1.5),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             const SizedBox(height: 20),

// //             // 👩‍💻 Our Mission
// //             Card(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //               elevation: 4,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(20),
// //                 child: Column(
// //                   children: const [
// //                     Text(
// //                       "Our Mission",
// //                       style: TextStyle(
// //                         fontSize: 22,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.deepPurple,
// //                       ),
// //                     ),
// //                     SizedBox(height: 10),
// //                     Text(
// //                       "Our mission is to simplify urban mobility while building a community of responsible and connected travelers. "
// //                       "We aim to encourage carpooling and reduce environmental impact while making every ride joyful.",
// //                       style: TextStyle(fontSize: 16, height: 1.5),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             const SizedBox(height: 20),

// //             // 💜 Thank You Section
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(20),
// //                 color: Colors.deepPurple[50],
// //                 border: Border.all(color: Colors.deepPurpleAccent, width: 2),
// //               ),
// //               child: Column(
// //                 children: [
// //                   const Text(
// //                     "💜 Special Thanks 💜",
// //                     style: TextStyle(
// //                       fontSize: 22,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.deepPurple,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 10),
// //                   const Text(
// //                     "We extend our heartfelt gratitude to the entire Core2Web team for their constant guidance, mentorship, "
// //                     "and inspiration. Their real-world training, practical learning, and continuous support helped us transform "
// //                     "ideas into impactful projects like VybeRide.",
// //                     style: TextStyle(fontSize: 16, height: 1.5),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                   const SizedBox(height: 20),
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(10),
// //                     child: Image.network(
// //                       "https://core2web.in/wp-content/uploads/2021/07/logo.png",
// //                       height: 60,
// //                       errorBuilder: (context, error, stackTrace) =>
// //                           const Icon(Icons.school, color: Colors.deepPurple, size: 50),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 10),
// //                   const Text(
// //                     "— Team VybeRide",
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w500,
// //                       color: Colors.black54,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 30),

// //             // 👥 Team Members Section
// //             const Text(
// //               "Our Team",
// //               style: TextStyle(
// //                 fontSize: 22,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.deepPurple,
// //               ),
// //             ),
// //             const SizedBox(height: 20),

// //             GridView.builder(
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               itemCount: teamMembers.length,
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 2,
// //                 mainAxisSpacing: 20,
// //                 crossAxisSpacing: 20,
// //                 childAspectRatio: 0.8,
// //               ),
// //               itemBuilder: (context, index) {
// //                 final member = teamMembers[index];
// //                 return Column(
// //                   children: [
// //                     CircleAvatar(
// //                       radius: 50,
// //                       backgroundImage: NetworkImage(member['image']!),
// //                     ),
// //                     const SizedBox(height: 10),
// //                     Text(
// //                       member['name']!,
// //                       style: const TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                     Text(
// //                       member['mentor']!,
// //                       style: const TextStyle(
// //                         fontSize: 14,
// //                         color: Colors.black54,
// //                       ),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ],
// //                 );
// //               },
// //             ),
// //             const SizedBox(height: 30),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }















// import 'package:flutter/material.dart';

// class AboutUsPage extends StatelessWidget {
//   const AboutUsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Team member data with asset images
//     final List<Map<String, String>> teamMembers = [
//       {"name": "Avishkar Jadhav", "image": "assets/avishkar.jpg"},
//       {"name": "Aadesh Landage", "image": "assets/aadesh.jpg"},
//       {"name": "Sakshi Sadgir", "image": "assets/sakshi.jpg"},
//       {"name": "Nikita Sidankar", "image": "assets/nikita.jpg"},
//     ];

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("About Us"),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // 🌿 Gradient Banner
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: const LinearGradient(
//                   colors: [Colors.green, Colors.lightGreen],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: const Text(
//                 "Welcome to Lansio!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🧭 About the Project
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: const [
//                     Text(
//                       "About Our Project",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "Lansio is an innovative platform designed for landscaping projects that brings contractors and workers together in a seamless way. "
//                       "It allows team members to communicate directly, coordinate tasks efficiently, and manage projects effectively. "
//                       "By simplifying collaboration and providing real-time updates, Lansio helps ensure that landscaping projects are completed faster, "
//                       "with higher quality, and with minimal miscommunication.",
//                       style: TextStyle(fontSize: 16, height: 1.5),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 👩‍💻 Our Mission
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: const [
//                     Text(
//                       "Our Mission",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "Our mission is to make landscaping projects simple, efficient, and collaborative. "
//                       "We aim to empower contractors and workers by providing a platform where they can communicate directly, "
//                       "manage tasks seamlessly, and complete projects with high quality and minimal delays. "
//                       "Lansio strives to bridge gaps in project coordination and enhance teamwork for better results in every landscaping project.",
//                       style: TextStyle(fontSize: 16, height: 1.5),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 💚 Special Thanks Section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.green[50],
//                 border: Border.all(color: Colors.greenAccent, width: 2),
//               ),
//               child: Column(
//                 children: [
//                   const Text(
//                     "💚 Special Thanks 💚",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   // Profile Pic from assets
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: AssetImage("assets/shashisir.jpg"),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Shashi Bagal Sir",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   const Text(
//                     "We extend our heartfelt gratitude to the entire Core2Web team for their constant guidance, mentorship, "
//                     "and inspiration. Their real-world training, practical learning, and continuous support helped us transform "
//                     "ideas into impactful projects like Lansio.",
//                     style: TextStyle(fontSize: 16, height: 1.5),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),

//             // 👥 Team Members Section
//             const Text(
//               "Our Team",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             const SizedBox(height: 20),

//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: teamMembers.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 20,
//                 crossAxisSpacing: 20,
//                 childAspectRatio: 0.8,
//               ),
//               itemBuilder: (context, index) {
//                 final member = teamMembers[index];
//                 return Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: AssetImage(member['image']!),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       member['name']!,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 );
//               },
//             ),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }











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
      return Tween<Offset>(
        begin: const Offset(0, 2),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _letterControllers[index],
        curve: Curves.easeOut,
      ));
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
    final List<Map<String, String>> teamMembers = [
      {"name": "Avishkar Jadhav", "image": "assets/avishkar.jpg"},
      {"name": "Aadesh Landage", "image": "assets/aadesh.jpg"},
      {"name": "Sakshi Sadgir", "image": "assets/sakshi.jpg"},
      {"name": "Nikita Sidankar", "image": "assets/nikita.jpg"},
    ];

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

            // 💚 Special Thanks Section (NO box)
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
                  backgroundImage: AssetImage("assets/shashisir.jpg"),
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

            // 👥 Team Members Section
            const Text(
              "Our Team",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 14),

            GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: teamMembers.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,       // 2 profiles per row
    mainAxisSpacing: 5,      // vertical spacing between rows reduced
    crossAxisSpacing: 10,    // horizontal spacing between columns
    childAspectRatio: 0.9,   // slightly taller to make avatars & names fit nicely
  ),
  itemBuilder: (context, index) {
    final member = teamMembers[index];
    return Column(
      mainAxisSize: MainAxisSize.min, // ensure column takes minimal vertical space
      children: [
        CircleAvatar(
          radius: 45, // profile size
          backgroundImage: AssetImage(member['image']!),
        ),
        const SizedBox(height: 2), // reduce distance between avatar and name
        Text(
          member['name']!,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  },
),

            const SizedBox(height: 1),
          ],
        ),
      ),
    );
  }
}
