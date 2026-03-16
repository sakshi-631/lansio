// import 'package:flutter/material.dart';
// import 'package:lansio/Controller/LoginPageController.dart';
// import 'package:lansio/View/LoginPage.dart';
// import 'package:lansio/View/SnackbarScreen.dart';
// import 'package:lansio/View/User/ExplorePage.dart';
// import 'package:lansio/View/User/User_Message_Page.dart';
// import 'package:lansio/View/User/User_Notification_page.dart';
// import 'package:lansio/View/User/User_ProfilePage.dart';
// import 'package:lansio/View/User/user_Homepage.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottommNavigationBarState();
// }

// class _BottommNavigationBarState extends State<BottomNavBar> {
//   int currentSelectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFECF2EC),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(50),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   Color.fromARGB(255, 90, 161, 75), // A light green
//                   Color.fromARGB(255, 70, 227, 78), // A darker green
//                 ],
//               ),
//             ),
//           ),

//           centerTitle: true,
//           title: Text(
//             getPageTitle(currentSelectedIndex),
//             style: const TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           actions: getPageActions(currentSelectedIndex),
//         ),
//       ),
//       body: pages(currentSelectedIndex),
//       bottomNavigationBar: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         child: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: const Color.fromARGB(255, 118, 222, 98),
//           currentIndex: currentSelectedIndex,
//           selectedItemColor: const Color.fromARGB(255, 1, 99, 4),
//           unselectedItemColor: const Color.fromARGB(255, 131, 131, 131),
//           onTap: (value) {
//             setState(() {
//               currentSelectedIndex = value;
//             });
//           },
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home, size: 30),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search_outlined, size: 30),
//               label: "Explore",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.messenger_outline_sharp, size: 30),
//               label: "Messages",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_3_outlined, size: 30),
//               label: "Profile",
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget pages(int index) {
//     switch (index) {
//       case 0:
//         return const Homepage();
//       case 1:
//         return const Explorepage(initialTabIndex: 0);
//       case 2:
//         return const UserMessagePage();
//       case 3:
//         return UserProfilePage();
//       default:
//         return Container();
//     }
//   }

//   // Return the title for each page
//   String getPageTitle(int index) {
//     switch (index) {
//       case 0:
//         return "LandConnect";
//       case 1:
//         return "Explore";
//       case 2:
//         return "Messages";
//       case 3:
//         return "Profile";
//       default:
//         return "";
//     }
//   }

//   // Return AppBar actions depending on page
//   List<Widget>? getPageActions(int index) {
//     if (index == 0) {
//       // Home page: add notification icon
//       return [
//         IconButton(
//           icon: const Icon(Icons.notifications_none, color: Colors.black),
//           onPressed: () {
//             // Handle notification tap
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) {
//                   return UserNotificationsPage();
//                 },
//               ),
//             );
//           },
//         ),
//       ];
//     } else if (index == 3) {
//       // Profile page: settings menu
//       return [
//         IconButton(
//           icon: const Icon(Icons.settings_outlined, color: Colors.black),
//           onPressed: () => _showSettingsMenu(),
//         ),
//       ];
//     }
//     return null; // no actions for other pages
//   }

//   // Settings menu for Profile page
//   void _showSettingsMenu() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.settings, color: Colors.blueGrey),
//                 title: const Text("Account Settings"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => UserProfilePage()),
//                   );
//                 },
//               ),
//               const Divider(),
//               ListTile(
//                 leading: const Icon(Icons.logout, color: Colors.redAccent),
//                 title: const Text("Logout"),
//                 onTap: () {
//                   Logincontroller().clearSharedPref();
//                   Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return Loginpage();
//                       },
//                     ),
//                     (route) => false,
//                   );
//                   Snackbarscreen().showCustomSnackBar(
//                     context,
//                     "Log Out Successful",
//                     bgColor: Colors.green,
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }









import 'package:flutter/material.dart';
import 'package:lansio/Controller/LoginPageController.dart';
import 'package:lansio/View/AboutUsPage.dart';
import 'package:lansio/View/LoginPage.dart';
import 'package:lansio/View/SnackbarScreen.dart';
import 'package:lansio/View/User/ExplorePage.dart';
import 'package:lansio/View/User/project_tender.dart'; // For Request page
import 'package:lansio/View/User/User_Notification_page.dart';
import 'package:lansio/View/User/User_ProfilePage.dart';
import 'package:lansio/View/User/user_Homepage.dart';
import 'package:lansio/View/User/User_Message_Page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottommNavigationBarState();
}

class _BottommNavigationBarState extends State<BottomNavBar> {
  int currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF2EC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color.fromARGB(255, 90, 161, 75), // Light green
                  Color.fromARGB(255, 70, 227, 78), // Darker green
                ],
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            getPageTitle(currentSelectedIndex),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: getPageActions(currentSelectedIndex),
        ),
      ),
      body: pages(currentSelectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 118, 222, 98),
          currentIndex: currentSelectedIndex,
          selectedItemColor: const Color.fromARGB(255, 1, 99, 4),
          unselectedItemColor: const Color.fromARGB(255, 131, 131, 131),
          onTap: (value) {
            setState(() {
              currentSelectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: 30),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined, size: 30),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.request_page_outlined, size: 30),
              label: "Request",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_3_outlined, size: 30),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  Widget pages(int index) {
    switch (index) {
      case 0:
        return const Homepage();
      case 1:
        return const Explorepage(initialTabIndex: 0);
      case 2:
        return const UserMessagePage();
      case 3:
        return const ProjectTender(); // Request section
      case 4:
        return UserProfilePage();
      default:
        return Container();
    }
  }

  // Return the title for each page
  String getPageTitle(int index) {
    switch (index) {
      case 0:
        return "Lansio";
      case 1:
        return "Explore";
      case 2:
        return "Messages";
      case 3:
        return "Requests";
      case 4:
        return "Profile";
      default:
        return "";
    }
  }

  // Return AppBar actions depending on page
  List<Widget>? getPageActions(int index) {
    if (index == 0) {
      // Home page: add notification icon
      return [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserNotificationsPage(),
              ),
            );
          },
        ),
      ];
    } else if (index == 4) {
      // Profile page: settings menu
      return [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () => _showSettingsMenu(),
        ),
      ];
    }
    return null; // no actions for other pages
  }

  // Settings menu for Profile page with "About Us" added
  void _showSettingsMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.blueGrey),
                title: const Text("Account Settings"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.teal),
                title: const Text("About Us"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AboutUsPage(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text("Logout"),
                onTap: () {
                  Logincontroller().clearSharedPref();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Loginpage()),
                    (route) => false,
                  );
                  Snackbarscreen().showCustomSnackBar(
                    context,
                    "Log Out Successful",
                    bgColor: Colors.green,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
