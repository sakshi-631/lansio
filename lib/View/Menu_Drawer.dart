// ignore_for_file: file_names

import 'package:flutter/material.dart';
class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
         
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text("Hello NextHorizon Guys", style: TextStyle(fontSize: 30)),
          ),
        ],
      ),
    );
  }
}
