// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class EditUserProfile extends StatefulWidget {
//   final Map<String, dynamic>? profileData;

//   const EditUserProfile({super.key, this.profileData});

//   @override
//   State<EditUserProfile> createState() => _EditUserProfileState();
// }

// class _EditUserProfileState extends State<EditUserProfile> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _linkedinController = TextEditingController();
//   final TextEditingController _telephoneController = TextEditingController();
//   final TextEditingController _jobInfoController = TextEditingController();

//   File? _profileImageFile;
//   File? _coverImageFile;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.profileData != null) {
//       _nameController.text = widget.profileData!['name'] ?? '';
//       _locationController.text = widget.profileData!['location'] ?? '';
//       _bioController.text = widget.profileData!['bio'] ?? '';
//       _emailController.text = widget.profileData!['email'] ?? '';
//       _mobileController.text = widget.profileData!['mobileNumber'] ?? '';
//       _linkedinController.text = widget.profileData!['linkedin'] ?? '';
//       _telephoneController.text = widget.profileData!['telephone'] ?? '';
//       _jobInfoController.text = widget.profileData!['jobInfo'] ?? '';

//       final profilePath = widget.profileData!['profileImage'];
//       if (profilePath != null && profilePath.isNotEmpty) {
//         _profileImageFile = File(profilePath);
//       }

//       final coverPath = widget.profileData!['coverImage'];
//       if (coverPath != null && coverPath.isNotEmpty) {
//         _coverImageFile = File(coverPath);
//       }
//     }
//   }

//   Future<void> _pickImage(bool isProfile) async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         if (isProfile) {
//           _profileImageFile = File(picked.path);
//         } else {
//           _coverImageFile = File(picked.path);
//         }
//       });
//     }
//   }

//   void _saveProfile() {
//     if (_formKey.currentState!.validate()) {
//       final updatedProfile = {
//         'name': _nameController.text.trim(),
//         'location': _locationController.text.trim(),
//         'bio': _bioController.text.trim(),
//         'email': _emailController.text.trim(),
//         'mobileNumber': _mobileController.text.trim(),
//         'linkedin': _linkedinController.text.trim(),
//         'telephone': _telephoneController.text.trim(),
//         'jobInfo': _jobInfoController.text.trim(),
//         'profileImage': _profileImageFile?.path,
//         'coverImage': _coverImageFile?.path,
//       };
//       Navigator.pop(context, updatedProfile);
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _locationController.dispose();
//     _bioController.dispose();
//     _emailController.dispose();
//     _mobileController.dispose();
//     _linkedinController.dispose();
//     _telephoneController.dispose();
//     _jobInfoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appGreen = const Color.fromARGB(255, 33, 111, 37);
//     final fieldFillColor = Colors.white;
//     final fieldBorderColor = Colors.grey.shade300;
//     final fieldIconColor = Colors.grey.shade700;
//     final sectionCardColor = Colors.grey.shade100;
//     final titleTextColor = Colors.grey.shade900;

//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         elevation: 1,
//         centerTitle: true,
//         leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () {
//         Navigator.pop(context); // Go back to previous screen
//       },
//   ),
//         title: Text(
//           widget.profileData == null ? 'Add Profile' : 'Edit Profile',
//           style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
//         ),
//         backgroundColor: appGreen,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 19),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildImageCircle(
//                     onTap: () => _pickImage(false),
//                     file: _coverImageFile,
//                     icon: Icons.photo_library,
//                     label: "Cover",
//                   ),
//                   const SizedBox(width: 30),
//                   _buildImageCircle(
//                     onTap: () => _pickImage(true),
//                     file: _profileImageFile,
//                     icon: Icons.camera_alt,
//                     label: "Profile",
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 22),
//               Card(
//                 color: sectionCardColor,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         "Personal Info",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: titleTextColor,
//                           fontSize: 17,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       _buildTextField(_nameController, 'Full Name', Icons.person, fieldFillColor, fieldBorderColor, fieldIconColor),
//                       const SizedBox(height: 12),
//                       _buildTextField(_jobInfoController, 'Job / Work Info', Icons.work_outline, fieldFillColor, fieldBorderColor, fieldIconColor),
//                       const SizedBox(height: 12),
//                       _buildTextField(_bioController, 'Bio (short one-liner)', Icons.info_outline, fieldFillColor, fieldBorderColor, fieldIconColor, maxLines: 1),
//                       const SizedBox(height: 12),
//                       _buildTextField(_locationController, 'Location', Icons.location_on, fieldFillColor, fieldBorderColor, fieldIconColor),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 18),
//               Card(
//                 color: sectionCardColor,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         "Contact & Links",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: titleTextColor,
//                           fontSize: 17,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildTextField(_emailController, 'Email', Icons.email, fieldFillColor, fieldBorderColor, fieldIconColor),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: _buildTextField(_mobileController, 'Mobile', Icons.phone, fieldFillColor, fieldBorderColor, fieldIconColor),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildTextField(_telephoneController, 'Telephone', Icons.phone_android, fieldFillColor, fieldBorderColor, fieldIconColor),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: _buildTextField(_linkedinController, 'LinkedIn URL', Icons.link, fieldFillColor, fieldBorderColor, fieldIconColor),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 28),
//               SizedBox(
//                 width: 200,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     elevation: 2,
//                     backgroundColor: appGreen,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(13),
//                     ),
//                   ),
//                   onPressed: _saveProfile,
//                   child: Text(
//                     widget.profileData == null ? 'Save' : 'Save Changes',
//                     style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildImageCircle({
//     required VoidCallback onTap,
//     required File? file,
//     required IconData icon,
//     required String label,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white,
//               border: Border.all(color: Colors.green.shade200, width: 2.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 3,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: CircleAvatar(
//               radius: 36,
//               backgroundColor: Colors.white,
//               backgroundImage: file != null ? FileImage(file) : null,
//               child: file == null
//                   ? Icon(icon, color: Colors.green.shade700, size: 22)
//                   : null,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.green.shade700,
//               fontWeight: FontWeight.w500,
//               fontSize: 13,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(
//       TextEditingController controller,
//       String label,
//       IconData icon,
//       Color fillColor,
//       Color borderColor,
//       Color iconColor,
//       {int maxLines = 1}) {
//     return TextFormField(
//       controller: controller,
//       maxLines: maxLines,
//       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: iconColor, size: 22),
//         labelText: label,
//         labelStyle: TextStyle(color: iconColor, fontSize: 14, fontWeight: FontWeight.w600),
//         filled: true,
//         fillColor: fillColor,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: borderColor)),
//         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.green.shade700, width: 2.0)),
//         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: borderColor, width: 1.0)),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
//       ),
//       validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
//     );
//   }
// }

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lansio/Controller/Contractor_editProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lansio/View/User/User_ProfilePage.dart';

class EditUserProfile extends StatefulWidget {
  final Map<String, dynamic> currentProfile;
  final Function(Map<String, dynamic>) onProfileUpdated;

  const EditUserProfile({
    super.key,
    required this.currentProfile,
    required this.onProfileUpdated,
  });

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ImagePicker profileImagePickerObj = ImagePicker();
  ImagePicker coverImagePickerObj = ImagePicker();

  // State variables for profile and cover images
  XFile? selectedProfileImage;
  XFile? selectedCoverImage;

  // Store the updated URLs after upload
  String? updatedProfileUrl;
  String? updatedCoverUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current profile data
    _nameController.text = widget.currentProfile['name'] ?? '';
    _emailController.text = widget.currentProfile['email'] ?? '';
    _phoneController.text = widget.currentProfile['mobile'] ?? '';
    _addressController.text = widget.currentProfile['address'] ?? '';
    _dobController.text = _formatDateForDisplay(widget.currentProfile['dob']);
    _bioController.text = widget.currentProfile['bio'] ?? '';
  }

  Future<void> _pickProfileImage() async {
    final picked = await profileImagePickerObj.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedProfileImage = picked;
      });
    }
  }

  Future<void> _pickCoverImage() async {
    final picked = await coverImagePickerObj.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedCoverImage = picked;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
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
      
      String downloadUrl = await ContractorEditprofile().downloadImage(fileName: fileName);
      log("Image URL: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }

  // Convert date string to Timestamp
  Timestamp? _parseDate(String dateString) {
    if (dateString.isEmpty) return null;
    try {
      List<String> parts = dateString.split('/');
      if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);
        DateTime date = DateTime(year, month, day);
        return Timestamp.fromDate(date);
      }
    } catch (e) {
      log("Error parsing date: $e");
    }
    return null;
  }

  String _formatDateForDisplay(dynamic date) {
    if (date == null) return '';
    if (date is Timestamp) {
      return "${date.toDate().day}/${date.toDate().month}/${date.toDate().year}";
    }
    if (date is String) return date;
    return '';
  }

  // Save profile to Firestore
  Future<void> _saveProfileToFirestore() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Upload images if new ones are selected
      if (selectedProfileImage != null) {
        String profileFileName = "user_profile_${DateTime.now().millisecondsSinceEpoch}";
        updatedProfileUrl = await _uploadImage(selectedProfileImage, profileFileName);
      }

      if (selectedCoverImage != null) {
        String coverFileName = "user_cover_${DateTime.now().millisecondsSinceEpoch}";
        updatedCoverUrl = await _uploadImage(selectedCoverImage, coverFileName);
      }

      // Get current user ID
      String? uid = auth.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not logged in");
      }

      // Prepare data for Firestore
      Map<String, dynamic> data = {
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "mobile": _phoneController.text.trim(),
        "address": _addressController.text.trim(),
        "bio": _bioController.text.trim(),
        "updatedAt": FieldValue.serverTimestamp(),
      };

      // Add date of birth if provided
      if (_dobController.text.isNotEmpty) {
        Timestamp? dobTimestamp = _parseDate(_dobController.text);
        if (dobTimestamp != null) {
          data["dob"] = dobTimestamp;
        }
      }

      // Add image URLs if they were updated, otherwise keep existing ones
      if (updatedProfileUrl != null) {
        data["profileImage"] = updatedProfileUrl;
      } else if (widget.currentProfile['profileImage'] != null) {
        data["profileImage"] = widget.currentProfile['profileImage'];
      }

      if (updatedCoverUrl != null) {
        data["coverImage"] = updatedCoverUrl;
      } else if (widget.currentProfile['coverImage'] != null) {
        data["coverImage"] = widget.currentProfile['coverImage'];
      }

      log("Updating user data for UID: $uid");
      log("Data to be saved: $data");

      // Update data in Firestore
      await firestore.collection('users').doc(uid).set(data, SetOptions(merge: true));

      // Create updated profile object
      final updatedProfile = Map<String, dynamic>.from(widget.currentProfile);
      updatedProfile.addAll(data);

      // Call the callback
      widget.onProfileUpdated(updatedProfile);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Updated Successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate back
      if (mounted) {
        Navigator.pop(context);
      }

    } catch (e) {
      log("Error saving profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _bioController.dispose();
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
              "Update Profile",
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                            if (selectedCoverImage == null && widget.currentProfile['coverImage'] == null)
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

                    // Email
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter your email' : null,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),

                    // Phone Number
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter your phone number' : null,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 15),

                    // Address
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.location_on),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter your address' : null,
                    ),
                    const SizedBox(height: 15),

                    // Date of Birth
                    TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.cake),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: _selectDate,
                        ),
                      ),
                      onTap: _selectDate,
                    ),
                    const SizedBox(height: 15),

                    // Bio
                    TextFormField(
                      controller: _bioController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'About Me',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignLabelWithHint: true,
                        prefixIcon: const Icon(Icons.info),
                      ),
                      validator: (value) => value!.isEmpty ? 'Please write something about yourself' : null,
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
                      onPressed: _isLoading ? null : _saveProfileToFirestore,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
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
                      onPressed: _isLoading ? null : () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16),
                      ),
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
    } else if (widget.currentProfile['profileImage'] != null && 
               widget.currentProfile['profileImage']!.isNotEmpty) {
      return NetworkImage(widget.currentProfile['profileImage']!);
    } else {
      return const AssetImage("assets/userprofile.jpeg");
    }
  }

  ImageProvider _getCoverImageProvider() {
    if (selectedCoverImage != null) {
      return FileImage(File(selectedCoverImage!.path));
    } else if (widget.currentProfile['coverImage'] != null && 
               widget.currentProfile['coverImage']!.isNotEmpty) {
      return NetworkImage(widget.currentProfile['coverImage']!);
    } else {
      return const NetworkImage("https://placehold.co/600x400/007AFF/ffffff?text=User+Cover");
    }
  }
}