// // lib/View/Contractor/Edit_Contractor_Profile.dart

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:lansio/View/Contractor/Contractor_Profile.dart'; // Import for ContractorProfile

// // Assuming ContractorEditprofile is a custom controller class for Firebase
// // Since it wasn't provided, I'm integrating the logic directly here for completeness.

// class EditContractorProfile extends StatefulWidget {
//   // Original profile data object
//   final ContractorProfile currentProfile;
//   // Callback to signal the parent screen (ContractorProfileScreen) to refresh
//   final void Function(ContractorProfile updatedProfile) onProfileUpdated;

//   // IMPORTANT: Removed the unused profileData map and simplified the constructor.
//   const EditContractorProfile({
//     super.key,
//     required this.currentProfile,
//     required this.onProfileUpdated,
//   });

//   @override
//   State<EditContractorProfile> createState() => _EditContractorProfileState();
// }

// class _EditContractorProfileState extends State<EditContractorProfile> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneNoController = TextEditingController();
//   final TextEditingController _aboutController = TextEditingController();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
  
//   // State variables for image files
//   XFile? selectedProfileImage;
//   XFile? selectedCoverImage;
  
//   // Existing image URLs (from Firestore, used for preview)
//   String? _currentProfileImageUrl;
//   String? _currentCoverImageUrl;

//   bool _isSaving = false;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with existing profile data
//     _nameController.text = widget.currentProfile.name;
//     // The phoneNo in the model maps to 'mobile' in Firestore
//     _phoneNoController.text = widget.currentProfile.mobile ?? '';
//     // The bio in the model maps to 'bio' in Firestore
//     _aboutController.text = widget.currentProfile.bio;
    
//     // Initialize existing image URLs
//     _currentProfileImageUrl = widget.currentProfile.profileImage;
//     // Assuming you'll add 'coverUrl' to your model and Firestore data
//     // For now, let's use a placeholder until you update the ContractorProfile model
//     // _currentCoverImageUrl = widget.currentProfile.coverUrl;
//   }

//   // --- Image Picking Functions ---

//   Future<void> _pickImage(ImageSource source, bool isProfile) async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: source);
//     if (picked != null) {
//       setState(() {
//         if (isProfile) {
//           selectedProfileImage = picked;
//           _currentProfileImageUrl = null; // Clear old URL for preview
//         } else {
//           selectedCoverImage = picked;
//           _currentCoverImageUrl = null; // Clear old URL for preview
//         }
//       });
//     }
//   }

//   // --- Image Upload and Save Function ---
  
//   // Helper to upload a single image
//   Future<String?> _uploadImage(XFile? file, String pathPrefix) async {
//     if (file == null) return null;

//     final userId = _auth.currentUser!.uid;
//     final fileName = '$pathPrefix/${userId}_${DateTime.now().millisecondsSinceEpoch}';
//     final storageRef = _storage.ref().child(fileName);

//     try {
//       await storageRef.putFile(File(file.path));
//       final downloadUrl = await storageRef.getDownloadURL();
//       return downloadUrl;
//     } on FirebaseException catch (e) {
//       log('Error uploading image to storage: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Image upload failed: ${e.message}')),
//       );
//       return null;
//     }
//   }

//   void _saveProfile() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
    
//     // Prevent multiple clicks
//     if (_isSaving) return;

//     setState(() {
//       _isSaving = true;
//     });

//     final userId = _auth.currentUser?.uid;
//     if (userId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('User not logged in.')),
//       );
//       setState(() => _isSaving = false);
//       return;
//     }

//     try {
//       // 1. Upload Images to Storage
//       // Use the existing URL if no new file was selected
//       final profileUrl = selectedProfileImage != null 
//           ? await _uploadImage(selectedProfileImage, 'profile_images')
//           : _currentProfileImageUrl;
          
//       final coverUrl = selectedCoverImage != null
//           ? await _uploadImage(selectedCoverImage, 'cover_images')
//           : _currentCoverImageUrl;

//       // Check if critical uploads failed (optional, but good for error handling)
//       if (selectedProfileImage != null && profileUrl == null) throw Exception("Profile image upload failed.");
//       if (selectedCoverImage != null && coverUrl == null) throw Exception("Cover image upload failed.");

//       // 2. Prepare Data for Firestore Update
//       final Map<String, dynamic> data = {
//         "name": _nameController.text.trim(),
//         "mobile": _phoneNoController.text.trim(), // Use 'mobile' to match your model's Firestore map
//         "bio": _aboutController.text.trim(), // Use 'bio' to match your model's Firestore map
//         // The image URLs are stored directly in the Firestore document
//         "profileImage": profileUrl, // Key from your ContractorProfile model
//         "coverUrl": coverUrl, // New key for the cover image
//       };

//       // 3. Update Firestore Document
//       await _firestore.collection('contractors').doc(userId).update(data);

//       // 4. Update UI and Navigate Back
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Profile Updated Successfully!')),
//       );

//       // Create a new updated profile object to send back or trigger a refresh
//       final updatedProfile = widget.currentProfile.copyWith(
//         name: data['name'],
//         mobile: data['mobile'],
//         phoneNo: data['mobile'], // Keep in sync
//         bio: data['bio'],
//         profileImage: data['profileImage'],
//         // Assuming you update the ContractorProfile model with 'coverUrl' later
//       );

//       widget.onProfileUpdated(updatedProfile); // Callback to refresh the parent
//       Navigator.pop(context);

//     } catch (e) {
//       log("Final Update Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred during save: $e')),
//       );
//     } finally {
//       setState(() {
//         _isSaving = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneNoController.dispose();
//     _aboutController.dispose();
//     super.dispose();
//   }
  
//   // Helper to get the correct ImageProvider for the UI
//   ImageProvider _getImageProvider(XFile? file, String? currentUrl, String fallbackUrl) {
//     if (file != null) {
//       return FileImage(File(file.path));
//     } else if (currentUrl != null && currentUrl.isNotEmpty) {
//       return NetworkImage(currentUrl);
//     } else {
//       return NetworkImage(fallbackUrl);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(40),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: AppBar(
//             centerTitle: true,
//             title: const Text(
//               "Update Details",
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Color.fromARGB(255, 255, 255, 255),
//               ),
//             ),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: <Color>[
//                     Color.fromARGB(255, 90, 161, 75),
//                     Color.fromARGB(255, 70, 227, 78),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // --- Cover Image Picker ---
//               GestureDetector(
//                 onTap: () => _pickImage(ImageSource.gallery, false), // isProfile: false
//                 child: Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(12),
//                     image: DecorationImage(
//                       image: _getImageProvider(
//                         selectedCoverImage, 
//                         _currentCoverImageUrl,
//                         "https://placehold.co/600x150/007AFF/ffffff?text=Tap+to+set+Cover+Image",
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // --- Profile Picture Picker ---
//               Center(
//                 child: GestureDetector(
//                   onTap: () => _pickImage(ImageSource.gallery, true), // isProfile: true
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundColor: Colors.grey.shade300,
//                     backgroundImage: _getImageProvider(
//                       selectedProfileImage,
//                       _currentProfileImageUrl,
//                       "https://placehold.co/120x120/007AFF/ffffff?text=Profile",
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),

//               // --- Form Fields ---

//               // Name
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Full Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 validator: (value) => value!.isEmpty ? 'Enter your name' : null,
//               ),
//               const SizedBox(height: 15),

//               // phoneNo (mobile in Firestore)
//               TextFormField(
//                 controller: _phoneNoController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter your phone number' : null,
//               ),
//               const SizedBox(height: 15),

//               // About (bio in Firestore)
//               TextFormField(
//                 controller: _aboutController,
//                 maxLines: 4,
//                 decoration: InputDecoration(
//                   labelText: 'About You / Company (Bio)',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   alignLabelWithHint: true,
//                 ),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please write something about you' : null,
//               ),
//               const SizedBox(height: 30),

//               // Save Button
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 90, 161, 75),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                     vertical: 15,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: _isSaving ? null : _saveProfile,
//                 child: _isSaving
//                     ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 3,
//                         ),
//                       )
//                     : const Text(
//                         'Save Changes',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






// // import 'dart:developer';

// // import 'package:flutter/material.dart';
// // import 'dart:io';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:lansio/Controller/Contractor_editProfile.dart';
// // import 'package:lansio/Controller/signupImageController.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:lansio/View/Contractor/Contractor_Profile.dart';

// // class EditContractorProfile extends StatefulWidget {
// //   // Existing data if editing. This map is expected to contain:
// //   // 'name', 'location', 'about', 'imagePath', and 'coverImagePath'.
// //   final Map<String, dynamic>? profileData;

// //   const EditContractorProfile({super.key, this.profileData, required void Function(ContractorProfile updatedProfile) onProfileUpdated, required ContractorProfile currentProfile});

// //   @override
// //   State<EditContractorProfile> createState() => _EditContractorProfileState();
// // }

// // class _EditContractorProfileState extends State<EditContractorProfile> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _phoneNoController = TextEditingController();
// //   final TextEditingController _aboutController = TextEditingController();

// //   final FirebaseAuth auth = FirebaseAuth.instance;

// //   ImagePicker profileImagePickerObj = ImagePicker();
// //   ImagePicker coverImagePickerObj = ImagePicker();

// //   // State variables for profile and cover images
// //   File? _profileImageFile;
// //   File? _coverImageFile;

// //   XFile? selectedProfileImage;
// //   XFile? selectedCoverImage;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Initialize controllers and image files from existing profile data
// //     if (widget.profileData != null) {
// //       _nameController.text = widget.profileData!['name'] ?? '';
// //       _phoneNoController.text = widget.profileData!['phoneNo'] ?? '';
// //       _aboutController.text = widget.profileData!['about'] ?? '';

// //       // Set initial profile image file if path exists
// //       final existingProfileImagePath = widget.profileData!['imagePath'];
// //       if (existingProfileImagePath != null) {
// //         _profileImageFile = File(existingProfileImagePath);
// //       }

// //       // Set initial cover image file if path exists
// //       final existingCoverImagePath = widget.profileData!['coverImagePath'];
// //       if (existingCoverImagePath != null) {
// //         _coverImageFile = File(existingCoverImagePath);
// //       }
// //     }
// //   }

// //   // --- Image Picking Functions ---

// //   // Future<void> _pickProfileImage() async {
// //   //   final picker = ImagePicker();
// //   //   final picked = await picker.pickImage(source: ImageSource.gallery);
// //   //   if (picked != null) {
// //   //     setState(() {
// //   //       _profileImageFile = File(picked.path);
// //   //     });
// //   //   }
// //   // }

// //   Future<void> _pickCoverImage() async {
// //     final picker = ImagePicker();
// //     final picked = await picker.pickImage(source: ImageSource.gallery);
// //     if (picked != null) {
// //       setState(() {
// //         _coverImageFile = File(picked.path);
// //       });
// //     }
// //   }

// //   // --- Save Function ---

// //   void _saveProfile() {
// //     if (_formKey.currentState!.validate()) {
// //       final Map<String, dynamic> updatedProfile = {
// //         'name': _nameController.text.trim(),
// //         'phoneNo': _phoneNoController.text.trim(),
// //         'about': _aboutController.text.trim(),
// //         // Save the new/updated file paths
// //         'imagePath': _profileImageFile?.path,
// //         'coverImagePath': _coverImageFile?.path,
// //       };

// //       // Return updated profile data back to previous page
// //       Navigator.pop(context, updatedProfile);

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text(
// //             widget.profileData == null
// //                 ? 'Profile Created Successfully!'
// //                 : 'Profile Updated Successfully!',
// //           ),
// //         ),
// //       );
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     _phoneNoController.dispose();
// //     _aboutController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // appBar: AppBar(
// //       //   title: Text(widget.profileData == null ? 'Add Profile' : 'Edit Profile'),
// //       //   backgroundColor: const Color.fromARGB(255, 122, 115, 225),
// //       // ),
// //       appBar: PreferredSize(
// //         preferredSize: Size.fromHeight(40),
// //         child: ClipRRect(
// //           borderRadius: BorderRadiusGeometry.circular(20),
// //           child: AppBar(
// //             centerTitle: true,
// //             title: Text(
// //               "Update Details",
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w600,
// //                 color: Color.fromARGB(255, 255, 255, 255),
// //               ),
// //             ),
// //             // 1. Set the background color to transparent
// //             backgroundColor: Colors.transparent,
// //             // 2. Remove the shadow (elevation)
// //             elevation: 0,

// //             // 3. Use the flexibleSpace property for the gradient
// //             flexibleSpace: Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                   colors: <Color>[
// //                     Color.fromARGB(255, 90, 161, 75), // A light green
// //                     Color.fromARGB(255, 70, 227, 78), // A darker green
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(20),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               // --- Cover Image Picker ---
// //               GestureDetector(
// //                 onTap: () async {
// //                   selectedCoverImage = await coverImagePickerObj.pickImage(
// //                     source: ImageSource.gallery,
// //                   );
// //                 },
// //                 child: Container(
// //                   height: 150,
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey.shade300,
// //                     borderRadius: BorderRadius.circular(12),
// //                     image: DecorationImage(
// //                       image: selectedCoverImage == null
// //                           ? const NetworkImage(
// //                               "https://sm.ign.com/ign_pk/cover/a/avatar-gen/avatar-generations_rpge.jpg",
// //                             )
// //                           : FileImage(File(selectedCoverImage!.path))
// //                                 as ImageProvider,
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                   // child: _coverImageFile == null
// //                   //     ? Center(
// //                   //         child: Column(
// //                   //           mainAxisAlignment: MainAxisAlignment.center,
// //                   //           children: const [
// //                   //             Icon(
// //                   //               Icons.photo_library,
// //                   //               color: Colors.grey,
// //                   //               size: 40,
// //                   //             ),
// //                   //             SizedBox(height: 8),
// //                   //             Text(
// //                   //               'Tap to set Cover Image',
// //                   //               style: TextStyle(color: Colors.grey),
// //                   //             ),
// //                   //           ],
// //                   //         ),
// //                   //       )
// //                   //     : null,
// //                 ),
// //               ),
// //               const SizedBox(height: 30),

// //               // --- Profile Picture Picker ---
// //               Center(
// //                 child: GestureDetector(
// //                   onTap: () async {
// //                     selectedProfileImage = await profileImagePickerObj
// //                         .pickImage(source: ImageSource.gallery);
// //                     log("Image Path : ${selectedProfileImage?.path}");
// //                     setState(() {});
// //                   },
// //                   child: CircleAvatar(
// //                     radius: 60,
// //                     backgroundColor: Colors.grey.shade300,
// //                     // If a file is selected, use FileImage, otherwise the child icon appears
// //                     backgroundImage: selectedProfileImage == null
// //                         ? NetworkImage(
// //                             "https://sm.ign.com/ign_pk/cover/a/avatar-gen/avatar-generations_rpge.jpg",
// //                           )
// //                         : FileImage(File(selectedProfileImage!.path)),
// //                     // child: (_profileImageFile == null)
// //                     //     ? const Icon(
// //                     //         Icons.camera_alt,
// //                     //         color: Colors.grey,
// //                     //         size: 40,
// //                     //       )
// //                     //     : null,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 25),

// //               // --- Form Fields ---

// //               // Name
// //               TextFormField(
// //                 controller: _nameController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Full Name',
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //                 validator: (value) => value!.isEmpty ? 'Enter your name' : null,
// //               ),
// //               const SizedBox(height: 15),

// //               // phoneNo
// //               TextFormField(
// //                 controller: _phoneNoController,
// //                 decoration: InputDecoration(
// //                   labelText: 'phoneNo',
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //                 validator: (value) =>
// //                     value!.isEmpty ? 'Enter your phoneNo' : null,
// //               ),
// //               const SizedBox(height: 15),

// //               // About
// //               TextFormField(
// //                 controller: _aboutController,
// //                 maxLines: 4,
// //                 decoration: InputDecoration(
// //                   labelText: 'About You / Company',
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   alignLabelWithHint: true,
// //                 ),
// //                 validator: (value) =>
// //                     value!.isEmpty ? 'Please write something about you' : null,
// //               ),
// //               const SizedBox(height: 30),

// //               // Save Button
// //               ElevatedButton(
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Color.fromARGB(255, 90, 161, 75),
// //                   padding: const EdgeInsets.symmetric(
// //                     horizontal: 40,
// //                     vertical: 15,
// //                   ),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //                 onPressed: () async {
// //                   //call to upload profile image
// //                   String coverFileName =
// //                       selectedCoverImage!.name + DateTime.now().toString();

// //                   ContractorEditprofile().uploadImage(
// //                     fileName: coverFileName,
// //                     selectedFile: File(selectedCoverImage!.path),
// //                   );

// //                   //call to upload profile image
// //                   String profileFileName =
// //                       selectedCoverImage!.name + DateTime.now().toString();

// //                   ContractorEditprofile().uploadImage(
// //                     fileName: profileFileName,
// //                     selectedFile: File(selectedProfileImage!.path),
// //                   );
// //                   // Download cover image from storage
// //                   String generatedUrlOfCover = await ContractorEditprofile()
// //                       .downloadImage(fileName: coverFileName);
// //                   log("coverImage Url : ${generatedUrlOfCover}");

// //                   // Download profile image from storage
// //                   String generatedUrlOfProfile = await ContractorEditprofile()
// //                       .downloadImage(fileName: coverFileName);
// //                   log("coverImage Url : ${generatedUrlOfProfile}");

// //                   //upload data to database
// //                   Map<String, dynamic> data = {
// //                     "name": _nameController.text,
// //                     "phoneNo": _phoneNoController.text,
// //                     "aboutUs": _aboutController,
// //                     "coverUrl": generatedUrlOfCover,
// //                     "profileUrl": generatedUrlOfProfile,
// //                   };
// //                   String? uid = auth.currentUser?.uid;
// //                   log("id of current user :${uid}");
// //                   ContractorEditprofile().addData(data: data, uid: uid);
// //                 },
// //                 child: Text(
// //                   'Save Changes',
// //                   style: const TextStyle(fontSize: 16, color: Colors.white),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


















// lib/View/Contractor/Edit_Contractor_Profile.dart

import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lansio/View/Contractor/Contractor_Profile.dart'; // Import for ContractorProfile

// Assuming ContractorEditprofile is a custom controller class for Firebase
// Since it wasn't provided, I'm integrating the logic directly here for completeness.

class EditContractorProfile extends StatefulWidget {
  // Original profile data object
  final ContractorProfile currentProfile;
  // Callback to signal the parent screen (ContractorProfileScreen) to refresh
  final void Function(ContractorProfile updatedProfile) onProfileUpdated;

  // IMPORTANT: Removed the unused profileData map and simplified the constructor.
  const EditContractorProfile({
    super.key,
    required this.currentProfile,
    required this.onProfileUpdated,
  });

  @override
  State<EditContractorProfile> createState() => _EditContractorProfileState();
}

class _EditContractorProfileState extends State<EditContractorProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  // State variables for image files
  XFile? selectedProfileImage;
  XFile? selectedCoverImage;
  
  // Existing image URLs (from Firestore, used for preview)
  String? _currentProfileImageUrl;
  String? _currentCoverImageUrl;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing profile data
    _nameController.text = widget.currentProfile.name;
    // The phoneNo in the model maps to 'mobile' in Firestore
    _phoneNoController.text = widget.currentProfile.mobile ?? '';
    // The bio in the model maps to 'bio' in Firestore
    _aboutController.text = widget.currentProfile.bio;
    
    // Initialize existing image URLs
    _currentProfileImageUrl = widget.currentProfile.profileImage;
    // Assuming you'll add 'coverUrl' to your model and Firestore data
    // For now, let's use a placeholder until you update the ContractorProfile model
    // _currentCoverImageUrl = widget.currentProfile.coverUrl;
  }

  // --- Image Picking Functions ---

  Future<void> _pickImage(ImageSource source, bool isProfile) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        if (isProfile) {
          selectedProfileImage = picked;
          _currentProfileImageUrl = null; // Clear old URL for preview
        } else {
          selectedCoverImage = picked;
          _currentCoverImageUrl = null; // Clear old URL for preview
        }
      });
    }
  }

  // --- Image Upload and Save Function ---
  
  // Helper to upload a single image
  Future<String?> _uploadImage(XFile? file, String pathPrefix) async {
    if (file == null) return null;

    final userId = _auth.currentUser!.uid;
    final fileName = '$pathPrefix/${userId}_${DateTime.now().millisecondsSinceEpoch}';
    final storageRef = _storage.ref().child(fileName);

    try {
      await storageRef.putFile(File(file.path));
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      log('Error uploading image to storage: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image upload failed: ${e.message}')),
      );
      return null;
    }
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    // Prevent multiple clicks
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
      setState(() => _isSaving = false);
      return;
    }

    try {
      // 1. Upload Images to Storage
      // Use the existing URL if no new file was selected
      final profileUrl = selectedProfileImage != null 
          ? await _uploadImage(selectedProfileImage, 'profile_images')
          : _currentProfileImageUrl;
          
      final coverUrl = selectedCoverImage != null
          ? await _uploadImage(selectedCoverImage, 'cover_images')
          : _currentCoverImageUrl;

      // Check if critical uploads failed (optional, but good for error handling)
      if (selectedProfileImage != null && profileUrl == null) throw Exception("Profile image upload failed.");
      if (selectedCoverImage != null && coverUrl == null) throw Exception("Cover image upload failed.");

      // 2. Prepare Data for Firestore Update
      final Map<String, dynamic> data = {
        "name": _nameController.text.trim(),
        "mobile": _phoneNoController.text.trim(), // Use 'mobile' to match your model's Firestore map
        "bio": _aboutController.text.trim(), // Use 'bio' to match your model's Firestore map
        // The image URLs are stored directly in the Firestore document
        "profileImage": profileUrl, // Key from your ContractorProfile model
        "coverUrl": coverUrl, // New key for the cover image
      };

      // 3. Update Firestore Document
      await _firestore.collection('contractors').doc(userId).update(data);

      // 4. Update UI and Navigate Back
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated Successfully!')),
      );

      // Create a new updated profile object to send back or trigger a refresh
      final updatedProfile = widget.currentProfile.copyWith(
        name: data['name'],
        mobile: data['mobile'],
        phoneNo: data['mobile'], // Keep in sync
        bio: data['bio'],
        profileImage: data['profileImage'],
        // Assuming you update the ContractorProfile model with 'coverUrl' later
      );

      widget.onProfileUpdated(updatedProfile); // Callback to refresh the parent
      Navigator.pop(context);

    } catch (e) {
      log("Final Update Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during save: $e')),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNoController.dispose();
    _aboutController.dispose();
    super.dispose();
  }
  
  // Helper to get the correct ImageProvider for the UI
  ImageProvider _getImageProvider(XFile? file, String? currentUrl, String fallbackUrl) {
    if (file != null) {
      return FileImage(File(file.path));
    } else if (currentUrl != null && currentUrl.isNotEmpty) {
      return NetworkImage(currentUrl);
    } else {
      return NetworkImage(fallbackUrl);
    }
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
                onTap: () => _pickImage(ImageSource.gallery, false), // isProfile: false
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: _getImageProvider(
                        selectedCoverImage, 
                        _currentCoverImageUrl,
                        "https://placehold.co/600x150/007AFF/ffffff?text=Tap+to+set+Cover+Image",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- Profile Picture Picker ---
              Center(
                child: GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery, true), // isProfile: true
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: _getImageProvider(
                      selectedProfileImage,
                      _currentProfileImageUrl,
                      "https://placehold.co/120x120/007AFF/ffffff?text=Profile",
                    ),
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
                ),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 15),

              // phoneNo (mobile in Firestore)
              TextFormField(
                controller: _phoneNoController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your phone number' : null,
              ),
              const SizedBox(height: 15),

              // About (bio in Firestore)
              TextFormField(
                controller: _aboutController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'About You / Company (Bio)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignLabelWithHint: true,
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
                onPressed: _isSaving ? null : _saveProfile,
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}