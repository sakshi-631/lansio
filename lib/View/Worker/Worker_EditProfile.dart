import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lansio/Controller/Contractor_editProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lansio/View/Worker/Worker_ProfilePage.dart';

class EditWorkerProfile extends StatefulWidget {
  final WorkerProfile currentProfile;
  final Function(WorkerProfile) onProfileUpdated;

  const EditWorkerProfile({
    super.key,
    required this.currentProfile,
    required this.onProfileUpdated,
  });

  @override
  State<EditWorkerProfile> createState() => _EditWorkerProfileState();
}

class _EditWorkerProfileState extends State<EditWorkerProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  ImagePicker profileImagePickerObj = ImagePicker();
  ImagePicker coverImagePickerObj = ImagePicker();

  // State variables for profile and cover images
  XFile? selectedProfileImage;
  XFile? selectedCoverImage;

  // Store the updated URLs after upload
  String? updatedProfileUrl;
  String? updatedCoverUrl;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current profile data
    _nameController.text = widget.currentProfile.name;
    _phoneNoController.text = widget.currentProfile.phoneNo;
    _aboutController.text = widget.currentProfile.aboutUs;
  }

  Future<void> _pickProfileImage() async {
    final picked = await profileImagePickerObj.pickImage(
      source: ImageSource.gallery,
    );
    if (picked != null) {
      setState(() {
        selectedProfileImage = picked;
      });
    }
  }

  Future<void> _pickCoverImage() async {
    final picked = await coverImagePickerObj.pickImage(
      source: ImageSource.gallery,
    );
    if (picked != null) {
      setState(() {
        selectedCoverImage = picked;
      });
    }
  }

  // Upload image and return download URL
  Future<String?> _uploadImage(XFile? image, String fileName) async {
    if (image == null) return null;

    try {
      await ContractorEditprofile().uploadImage(
        fileName: fileName,
        selectedFile: File(image.path),
      );

      String downloadUrl = await ContractorEditprofile().downloadImage(
        fileName: fileName,
      );
      log("Image URL: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }

  // Save profile to Firestore
  Future<void> _saveProfileToFirestore() async {
    try {
      // Upload images if new ones are selected
      if (selectedProfileImage != null) {
        String profileFileName =
            "profile_${DateTime.now().millisecondsSinceEpoch}";
        updatedProfileUrl = await _uploadImage(
          selectedProfileImage,
          profileFileName,
        );
      }

      if (selectedCoverImage != null) {
        String coverFileName = "cover_${DateTime.now().millisecondsSinceEpoch}";
        updatedCoverUrl = await _uploadImage(selectedCoverImage, coverFileName);
      }

      // Prepare data for Firestore
      Map<String, dynamic> data = {
        "name": _nameController.text.trim(),
        "phoneNo": _phoneNoController.text.trim(),
        "aboutUs": _aboutController.text.trim(),
        "updatedAt": FieldValue.serverTimestamp(),
      };

      // Add image URLs if they were updated
      if (updatedProfileUrl != null) {
        data["profileUrl"] = updatedProfileUrl;
      }
      if (updatedCoverUrl != null) {
        data["coverUrl"] = updatedCoverUrl;
      }

      // Get current user ID
      String? uid = auth.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not logged in");
      }

      log("Updating worker data: $data");

      // Update data in Firestore
      await ContractorEditprofile().addData(data: data, uid: uid);

      // Create updated profile object
      final updatedProfile = widget.currentProfile.copyWith(
        name: _nameController.text.trim(),
        phoneNo: _phoneNoController.text.trim(),
        aboutUs: _aboutController.text.trim(),
        profileUrl: updatedProfileUrl ?? widget.currentProfile.profileUrl,
        coverUrl: updatedCoverUrl ?? widget.currentProfile.coverUrl,
      );

      // Call the callback
      widget.onProfileUpdated(updatedProfile);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Updated Successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back
      Navigator.pop(context);
    } catch (e) {
      log("Error saving profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNoController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AppBar(
            centerTitle: true,
            title: const Text(
              "Update Details",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromARGB(255, 90, 161, 75),
                    Color.fromARGB(255, 70, 227, 78),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Cover Image Picker ---
              GestureDetector(
                onTap: _pickCoverImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: _getCoverImageProvider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      if (selectedCoverImage == null &&
                          widget.currentProfile.coverUrl == null)
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_library,
                                color: Colors.grey,
                                size: 40,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tap to set Cover Image',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- Profile Picture Picker ---
              Center(
                child: GestureDetector(
                  onTap: _pickProfileImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: _getProfileImageProvider(),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 90, 161, 75),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // --- Form Fields ---

              // Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 15),

              // Phone Number
              TextFormField(
                controller: _phoneNoController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your phone number' : null,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15),

              // About
              TextFormField(
                controller: _aboutController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'About You',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.info),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please write something about you' : null,
              ),
              const SizedBox(height: 30),

              // Save Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 90, 161, 75),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _saveProfileToFirestore();
                  }
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              // Cancel Button
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _getProfileImageProvider() {
    if (selectedProfileImage != null) {
      return FileImage(File(selectedProfileImage!.path));
    } else if (widget.currentProfile.profileUrl != null &&
        widget.currentProfile.profileUrl!.isNotEmpty) {
      return NetworkImage(widget.currentProfile.profileUrl!);
    } else {
      return const NetworkImage(
        "https://sm.ign.com/ign_pk/cover/a/avatar-gen/avatar-generations_rpge.jpg",
      );
    }
  }

  ImageProvider _getCoverImageProvider() {
    if (selectedCoverImage != null) {
      return FileImage(File(selectedCoverImage!.path));
    } else if (widget.currentProfile.coverUrl != null &&
        widget.currentProfile.coverUrl!.isNotEmpty) {
      return NetworkImage(widget.currentProfile.coverUrl!);
    } else {
      return const NetworkImage(
        "https://placehold.co/600x400/007AFF/ffffff?text=Worker+Cover",
      );
    }
  }
}
