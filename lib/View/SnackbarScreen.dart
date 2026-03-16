// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Snackbarscreen {
  showCustomSnackBar(
    BuildContext context,
    String msg, {
    Color bgColor = Colors.green,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        backgroundColor: bgColor,
      ),
    );
  }
}
