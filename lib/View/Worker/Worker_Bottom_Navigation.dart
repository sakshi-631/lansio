

import 'package:flutter/material.dart';
import 'package:lansio/Controller/LoginPageController.dart';
import 'package:lansio/View/LoginPage.dart';
import 'package:lansio/View/SnackbarScreen.dart';
import 'package:lansio/View/User/User_Notification_page.dart';
import 'package:lansio/View/Worker/Worker_HomePage.dart';
import 'package:lansio/View/Worker/Worker_Message_Page.dart'; // ✅ updated import
import 'package:lansio/View/Worker/Worker_ProfilePage.dart';
import 'package:lansio/View/Worker/Worker_RequestPage.dart';

class WorkerBottomNavigation extends StatefulWidget {
  const WorkerBottomNavigation({super.key});

  @override
  State<WorkerBottomNavigation> createState() => _WorkerBottomNavigationState();
}

class _WorkerBottomNavigationState extends State<WorkerBottomNavigation> {
  List<String> title = [
    "Current Contracts",
    "Client's Request",
    "Messages",
    "Profile",
  ];

  int currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: AppBar(
            centerTitle: true,
            title: Text(
              title[currentSelectedIndex],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: getPageActions(currentSelectedIndex),
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
        ),
      ),
      body: pages(currentSelectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(30),
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
              icon: Icon(Icons.request_page_outlined, size: 30),
              label: "Request",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outline_sharp, size: 30),
              label: "Message",
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

  /// ✅ Page Routing Based on Index
  Widget pages(int currentSelectedIndex) {
    switch (currentSelectedIndex) {
      case 0:
        return const WorkerHomePage();
      case 1:
        return const WorkerRequestScreen();
      case 2:
        return const WorkerMessagePage(); // ✅ updated to new message page
      case 3:
        return const WorkerProfilePage();
      default:
        return const WorkerHomePage();
    }
  }

  /// ✅ AppBar Action Buttons (for Profile page)
  List<Widget> getPageActions(int index) {
    if (index == 3) {
      return [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: _showSettingsMenu,
        ),
      ];
    }
    return [];
  }

  /// ✅ Settings Menu (bottom sheet)
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Navigate to detailed settings page"),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                  _performLogout();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// ✅ Logout Logic
  void _performLogout() {
    Logincontroller().clearSharedPref();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Loginpage()),
      (route) => false,
    );
    Snackbarscreen().showCustomSnackBar(
      context,
      "Log Out Successful",
      bgColor: Colors.green,
    );
  }
}
