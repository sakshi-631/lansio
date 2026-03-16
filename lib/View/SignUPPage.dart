import 'dart:io';

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lansio/Controller/signupImageController.dart';
import 'package:lansio/Model/AccountTypeModel.dart';
import 'package:lansio/View/LoginPage.dart';
import 'package:lansio/View/Select_whoislogin.dart';
import 'package:lansio/View/SnackbarScreen.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({super.key});

  @override
  State<SignUPPage> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<SignUPPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passController = TextEditingController();

  File? profileImage;
  final ImagePicker picker = ImagePicker();
  DateTime? selectedDate;
  XFile? selectedImgFile;
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
        selectedImgFile = pickedFile; // save XFile too if needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/signupbackground.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Lansio",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 24, 21, 21),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSignupForm(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ), // adjust blur intensity
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2), // semi-transparent
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ), // optional border for glass effect
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.green.shade50,
                  backgroundImage: profileImage != null
                      ? FileImage(profileImage!)
                      : null,
                  child: profileImage == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 34,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 25),
              _buildRoundedTextField(nameController, "Username", Icons.person),
              const SizedBox(height: 16),
              _buildRoundedTextField(emailController, "Email", Icons.email),
              const SizedBox(height: 16),
              _buildRoundedTextField(
                passController,
                "Password",
                Icons.lock,
                obscure: true,
              ),
              const SizedBox(height: 16),
              _buildRoundedTextField(mobileController, "Mobile", Icons.phone),
              const SizedBox(height: 16),
              _buildRoundedTextField(addressController, "Address", Icons.home),
              const SizedBox(height: 16),
              _buildDatePicker(),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () async {
                  if (emailController.text.trim().isEmpty ||
                      passController.text.trim().isEmpty ||
                      nameController.text.trim().isEmpty ||
                      mobileController.text.trim().isEmpty ||
                      addressController.text.trim().isEmpty ||
                      selectedDate == null) {
                    Snackbarscreen().showCustomSnackBar(
                      context,
                      "Please fill all required fields",
                      bgColor: Colors.red,
                    );
                    return;
                  }

                  try {
                    final userCredential = await firebaseAuth
                        .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text,
                        );

                    String imageUrl = "";
                    if (profileImage != null) {
                      
                      imageUrl = await SignupImageController()
                          .uploadProfileImage(
                            profileImage!,
                            userCredential.user!.uid,
                          );
                      
                    } else {
                     
                      imageUrl = "";
                    }

                    final user = AccountTypeModelFull(
                      userId: userCredential.user!.uid,
                      name: nameController.text,
                      email: emailController.text,
                      mobile: mobileController.text,
                      address: addressController.text,
                      dob: selectedDate != null ? selectedDate.toString() : '',
                      profileImage: imageUrl,
                    );

                    
                    // Navigate to Account Type Page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AccountTypePage(user: user);
                        },
                      ),
                    );
                  } on FirebaseAuthException catch (error) {
                    Snackbarscreen().showCustomSnackBar(
                      context,
                      error.message ?? "Signup failed",
                      bgColor: Colors.red,
                    );
                  }
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Loginpage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Log In",
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
      ),
    );
  }

  Widget _buildRoundedTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.green),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1960),
          lastDate: DateTime.now(),
        );
        if (date != null) setState(() => selectedDate = date);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? "Select Date of Birth"
                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            ),
            const Icon(Icons.calendar_today, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
