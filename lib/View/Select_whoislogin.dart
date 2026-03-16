// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lansio/Controller/signupImageController.dart';
import 'package:lansio/Model/AccountTypeModel.dart';
import 'package:lansio/Model/Signup_Account_Type.dart';
import 'package:lansio/View/LoginPage.dart';
import 'package:lansio/View/SnackbarScreen.dart';

class AccountTypePage extends StatefulWidget {
  final AccountTypeModelFull user;

  const AccountTypePage({super.key, required this.user});

  @override
  State<AccountTypePage> createState() => _AccountTypePageState();
}

class _AccountTypePageState extends State<AccountTypePage> {
  String? selectedType;

  final List<AccountTypeModel> accountTypes = [
    AccountTypeModel(
      label: 'User Account',
      subtitle: 'For individuals seeking services.',
      asset: 'assets/user.png',
    ),
    AccountTypeModel(
      label: 'Contractor Account',
      subtitle: 'For businesses and freelancers offering services.',
      asset: 'assets/contractor.webp',
    ),
    AccountTypeModel(
      label: 'Worker Account',
      subtitle: 'For individuals looking to work.',
      asset: 'assets/worker.jpg',
    ),
  ];

  Future<void> saveAccountData() async {
    if (selectedType == null) {
      Snackbarscreen().showCustomSnackBar(
        context,
        "Please select an account type",
        bgColor: Colors.red,
      );
      return;
    }

    try {
      widget.user.accountType = selectedType!;

      String collection;
      if (selectedType == 'User Account') {
        collection = 'users';
      } else if (selectedType == 'Contractor Account') {
        collection = 'contractors';
      } else {
        collection = 'workers';
      }

      final Map<String, dynamic> userData = {
        'userId': widget.user.userId,
        'name': widget.user.name,
        'email': widget.user.email,
        'mobile': widget.user.mobile,
        'address': widget.user.address,
        'dob': widget.user.dob,
        'profileImage': widget.user.profileImage ?? 'EMPTY_IMAGE_FIELD',
        'accountType': widget.user.accountType ?? '',
        'createdAt': DateTime.now(),
      };

      await SignupImageController().addData(
        collection,
        widget.user.userId,
        userData,
      );

      Snackbarscreen().showCustomSnackBar(
        context,
        "Account setup successful 🎉",
        bgColor: Colors.green,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Loginpage();
          },
        ),
      );
    } catch (e) {
      Snackbarscreen().showCustomSnackBar(
        context,
        "Error saving account: $e",
        bgColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5F7ED), Color(0xFFB4E1BE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Select your account type to continue',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 34),
                ...accountTypes.map(
                  (type) => GestureDetector(
                    onTap: () => setState(() => selectedType = type.label),
                    child: Card(
                      color: selectedType == type.label
                          ? Colors.green.shade50
                          : Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: selectedType == type.label
                              ? Colors.green
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(type.asset),
                        ),
                        title: Text(type.label),
                        subtitle: Text(type.subtitle),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: saveAccountData,
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
