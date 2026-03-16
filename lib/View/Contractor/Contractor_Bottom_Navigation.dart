// import 'package:flutter/material.dart';
// import 'package:lansio/Controller/LoginPageController.dart';
// import 'package:lansio/View/Contractor/Contractor_Message_Page.dart'; // ✅ updated import
// import 'package:lansio/View/Contractor/Contractor_Profile.dart';
// import 'package:lansio/View/Contractor/Contractor_Request_Page.dart';
// import 'package:lansio/View/Contractor/Current_Contracts.dart';
// import 'package:lansio/View/Contractor/contractor_Notification.dart';
// import 'package:lansio/View/LoginPage.dart';

// class ContractorBottomNavigation extends StatefulWidget {
//   const ContractorBottomNavigation({super.key});

//   @override
//   State<ContractorBottomNavigation> createState() =>
//       _ContractorBottomNavigationState();
// }

// class _ContractorBottomNavigationState
//     extends State<ContractorBottomNavigation> {
//   int currentSelectedIndex = 0;

//   final List<String> title = [
//     "Current Contracts",
//     "Client's Request",
//     "Messages",
//     "Profile",
//   ];

//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Profile Options"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 title: const Text(
//                   "Logout",
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Logincontroller().clearSharedPref();
//                   Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(builder: (_) => const Loginpage()),
//                     (Route<dynamic> route) => false,
//                   );
//                   print("User logged out!");
//                 },
//               ),
//               ListTile(
//                 title: const Text("Cancel"),
//                 onTap: () => Navigator.of(context).pop(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   List<Widget>? getPageActions(int index) {
//     if (index == 0) {
//       return [
//         IconButton(
//           icon: const Icon(Icons.notifications_none, color: Colors.black),
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (_) => const ContractorNotification()),
//             );
//           },
//         ),
//       ];
//     } else if (index == 3) {
//       return [
//         IconButton(
//           icon: const Icon(Icons.settings_outlined, color: Colors.black),
//           onPressed: () => _showLogoutDialog(context),
//         ),
//       ];
//     }
//     return null;
//   }

//   Widget pages(int index) {
//     switch (index) {
//       case 0:
//         return const CurrentContracts();
//       case 1:
//         return const ClientRequestScreen();
//       case 2:
//         return const ContractorMessagePage(); // ✅ updated navigation
//       case 3:
//         return const ContractorProfileScreen();
//       default:
//         return const Center(
//           child: Text(
//             "Page not found",
//             style: TextStyle(fontSize: 18, color: Colors.grey),
//           ),
//         );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           title[currentSelectedIndex],
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         actions: getPageActions(currentSelectedIndex),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color.fromARGB(255, 90, 161, 75),
//                 Color.fromARGB(255, 70, 227, 78),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: pages(currentSelectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: const Color.fromARGB(255, 118, 222, 98),
//         currentIndex: currentSelectedIndex,
//         selectedItemColor: const Color.fromARGB(255, 1, 99, 4),
//         unselectedItemColor: Colors.grey,
//         onTap: (value) => setState(() => currentSelectedIndex = value),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined, size: 30),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.request_page_outlined, size: 30),
//             label: "Request",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message_outlined, size: 30),
//             label: "Messages",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_3_outlined, size: 30),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth
import 'package:lansio/Controller/LoginPageController.dart';
import 'package:lansio/View/Contractor/Contractor_Message_Page.dart'; // ✅ Updated message page
import 'package:lansio/View/Contractor/Contractor_Profile.dart';
import 'package:lansio/View/Contractor/Contractor_Request_Page.dart';
import 'package:lansio/View/Contractor/Current_Contracts.dart';
import 'package:lansio/View/Contractor/contractor_Notification.dart';
import 'package:lansio/View/LoginPage.dart';

class ContractorBottomNavigation extends StatefulWidget {
  const ContractorBottomNavigation({super.key});

  @override
  State<ContractorBottomNavigation> createState() =>
      _ContractorBottomNavigationState();
}

class _ContractorBottomNavigationState
    extends State<ContractorBottomNavigation> {

  // 🆕 Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int currentSelectedIndex = 0;

  final List<String> title = [
    "Current Contracts",
    "Client's Request",
    "Messages",
    "Profile",
  ];

  // 🆕 Stream for unread notifications badge
  Stream<int> get _unreadNotificationCountStream {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value(0);
    return _firestore
        .collection('notifications')
        .where('requestedToId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Logout dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Profile Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Logincontroller().clearSharedPref();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const Loginpage()),
                    (Route<dynamic> route) => false,
                  );
                  print("User logged out!");
                },
              ),
              ListTile(
                title: const Text("Cancel"),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  // AppBar actions based on current tab
  List<Widget>? getPageActions(int index) {
    if (index == 0) {
      // Home: show notification badge
      return [
        StreamBuilder<int>(
          stream: _unreadNotificationCountStream,
          initialData: 0,
          builder: (context, snapshot) {
            final unreadCount = snapshot.data ?? 0;
            return IconButton(
              icon: Stack(
                children: [
                  const Icon(Icons.notifications_none, color: Colors.black),
                  if (unreadCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          unreadCount > 9 ? '9+' : '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ContractorNotification(),
                  ),
                );
              },
            );
          },
        ),
      ];
    } else if (index == 3) {
      // Profile: show settings/logout
      return [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.black),
          onPressed: () => _showLogoutDialog(context),
        ),
      ];
    }
    return null;
  }

  // Map index to page
  Widget pages(int index) {
    switch (index) {
      case 0:
        return const CurrentContracts();
      case 1:
        return const ClientRequestScreen();
      case 2:
        return const ContractorMessagePage(); // ✅ updated
      case 3:
        return const ContractorProfileScreen();
      default:
        return const Center(
          child: Text(
            "Page not found",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title[currentSelectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: getPageActions(currentSelectedIndex),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 90, 161, 75),
                Color.fromARGB(255, 70, 227, 78),
              ],
            ),
          ),
        ),
      ),
      body: pages(currentSelectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 118, 222, 98),
        currentIndex: currentSelectedIndex,
        selectedItemColor: const Color.fromARGB(255, 1, 99, 4),
        unselectedItemColor: Colors.grey,
        onTap: (value) => setState(() => currentSelectedIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page_outlined, size: 30),
            label: "Request",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined, size: 30),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined, size: 30),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
