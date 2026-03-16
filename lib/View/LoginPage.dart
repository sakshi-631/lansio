// ignore_for_file: file_names

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lansio/Controller/LoginPageController.dart';
import 'package:lansio/View/BottomNavBar.dart';
import 'package:lansio/View/Contractor/Contractor_Bottom_Navigation.dart';
import 'package:lansio/View/SignUPPage.dart';
import 'package:lansio/View/SnackbarScreen.dart';
import 'package:lansio/View/Worker/Worker_Bottom_Navigation.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final FirebaseAuth _firebaseAuthobj = FirebaseAuth.instance;

  void forgotPassword() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController emailResetController =
            TextEditingController(text: emailController.text);
        return AlertDialog(
          title: const Text("Reset Password"),
          content: TextField(
            controller: emailResetController,
            decoration: const InputDecoration(
              hintText: "Enter your registered email",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (emailResetController.text.trim().isNotEmpty) {
                  try {
                    await _firebaseAuthobj.sendPasswordResetEmail(
                        email: emailResetController.text.trim());
                    Navigator.of(context).pop();
                    Snackbarscreen().showCustomSnackBar(
                      context,
                      "Password reset email sent!",
                      bgColor: Colors.green,
                    );
                  } on FirebaseAuthException catch (error) {
                    Navigator.of(context).pop();
                    Snackbarscreen().showCustomSnackBar(
                      context,
                      error.message ?? "Failed to send reset email",
                      bgColor: Colors.red,
                    );
                  }
                } else {
                  Snackbarscreen().showCustomSnackBar(
                    context,
                    "Please enter your email",
                    bgColor: Colors.red,
                  );
                }
              },
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }
  // -------------------------------------------------------

  Future<void> handleLogin() async {
    if (emailController.text.trim().isNotEmpty ||
        passController.text.trim().isNotEmpty) {
      try {
        UserCredential userCredential = await _firebaseAuthobj
            .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim(),
            );

        final uid = userCredential.user!.uid;

        String? accountType;
        List<String> collections = ['users', 'contractors', 'workers'];
        for (String col in collections) {
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
          Snackbarscreen().showCustomSnackBar(
            context,
            "Account type not found",
            bgColor: Colors.red,
          );
          return;
        }

        Logincontroller logincontrollerobj = Logincontroller();
        await logincontrollerobj.setSharedPrefData({
          'email': emailController.text.trim(),
          'password': passController.text.trim(),
          'loginflag': true,
          'seenOnboarding': true, 
          'accountType': accountType,
        });

        Snackbarscreen().showCustomSnackBar(
          context,
          "Login Successfully",
          bgColor: Colors.green,
        );

        emailController.clear();
        passController.clear();

        // Navigate based on account type
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
      } on FirebaseAuthException catch (error) {
        Snackbarscreen().showCustomSnackBar(
          context,
          error.message ?? "Login Failed",
          bgColor: Colors.red,
        );
      }
    } else {
      Snackbarscreen().showCustomSnackBar(
        context,
        "Enter valid details",
        bgColor: Colors.red,
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset("assets/loginbg.jpg", fit: BoxFit.cover),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    IgnorePointer(
                      ignoring: true,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                              prefixIcon: const Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: passController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              prefixIcon: const Icon(Icons.lock),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: forgotPassword,
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 99, 250, 107),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.all(7),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.phone,
                                  color: Colors.green),
                              label: const Text(
                                "Continue with Phone Number",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                side: const BorderSide(color: Colors.green),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const SignUPPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 27, 252, 6),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
