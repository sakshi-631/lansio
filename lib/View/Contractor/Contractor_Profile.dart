// // lib/View/Contractor/Contractor_Profile.dart

// import 'dart:io'; 

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; 

// import 'package:lansio/View/Contractor/Edit_Contractor_Profile.dart';
// import 'package:lansio/View/Contractor/FullScreenPostViewer.dart'; // <<< NEW: Import the viewer

// // --- Profile Data Model ---
// class ContractorProfile {
//   final String name;
//   final String phoneNo; // Note: This field will hold data['mobile'] from Firestore
//   final double rating;
//   final String bio;
//   final List<String> postUrls;
//   final String? profileImage; // This is the profile picture URL
//   final String? coverUrl;     // <<< NEW: Cover Image URL
//   final String? email;
//   final String? mobile;

//   const ContractorProfile({
//     required this.name,
//     required this.phoneNo,
//     required this.rating,
//     required this.bio,
//     required this.postUrls,
//     this.profileImage,
//     this.coverUrl,
//     this.email,
//     this.mobile,
//   });

//   // Factory constructor to create from Firestore data
//   factory ContractorProfile.fromFirestore(Map<String, dynamic> data) {
//     return ContractorProfile(
//       name: data['name'] ?? 'Contractor Name Not Set',
//       phoneNo: data['mobile'] ?? 'Phone not set', // Use dynamic data['mobile'] for the primary phone display
//       rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
//       bio: data['bio'] ?? 'No bio available. Please edit your profile to add one.', // Maps to 'bio'
//       postUrls: List<String>.from(data['postUrls'] ?? []),
//       profileImage: data['profileImage'], // Maps to 'profileImage'
//       coverUrl: data['coverUrl'],       // <<< NEW: Read 'coverUrl' from data
//       email: data['email'],
//       mobile: data['mobile'],
//     );
//   }

//   // A helper method for creating an editable copy (used for forms)
//   ContractorProfile copyWith({
//     String? name,
//     String? phoneNo,
//     double? rating,
//     String? bio,
//     List<String>? postUrls,
//     String? profileImage,
//     String? coverUrl,
//     String? email,
//     String? mobile,
//   }) {
//     return ContractorProfile(
//       name: name ?? this.name,
//       phoneNo: phoneNo ?? this.phoneNo,
//       rating: rating ?? this.rating,
//       bio: bio ?? this.bio,
//       postUrls: postUrls ?? this.postUrls,
//       profileImage: profileImage ?? this.profileImage,
//       coverUrl: coverUrl ?? this.coverUrl, // <<< NEW: Copy coverUrl
//       email: email ?? this.email,
//       mobile: mobile ?? this.mobile,
//     );
//   }
// }

// // --- The Main Profile Screen Widget (Stateful to allow updates) ---
// class ContractorProfileScreen extends StatefulWidget {
//   const ContractorProfileScreen({super.key});

//   @override
//   State<ContractorProfileScreen> createState() =>
//       _ContractorProfileScreenState();
// }

// class _ContractorProfileScreenState extends State<ContractorProfileScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance; 

//   // Real-time stream for contractor data (Reads from 'contractors' collection)
//   Stream<ContractorProfile?> get contractorDataStream {
//     final userId = _auth.currentUser?.uid;
//     if (userId == null) return Stream.value(null);

//     return _firestore.collection('contractors').doc(userId).snapshots().map((
//       snapshot,
//     ) {
//       if (snapshot.exists && snapshot.data() != null) {
//         return ContractorProfile.fromFirestore(snapshot.data()!);
//       }
//       return null;
//     });
//   }

//   // Use this function to refresh the screen after an update
//   void _refreshProfile(ContractorProfile updatedProfile) {
//     // The StreamBuilder handles the refresh automatically, but this method
//     // ensures the navigation in the Edit screen can call back to the parent.
//     setState(() {
//       // The stream will reload the latest data, so we just trigger a rebuild.
//     });
//   }

//   void _handleAddPost() async {
//     final userId = _auth.currentUser?.uid;
//     if (userId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please log in to add a post.')),
//       );
//       return;
//     }

//     // 1. Pick Image or Video
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickMedia(
//       imageQuality: 70, // Optimize image size
//     );

//     if (pickedFile == null) return; // User cancelled

//     // Show a temporary indicator while processing
//     final SnackBar processingSnackbar = const SnackBar(
//       content: Text('Uploading post... Please wait.'),
//       duration: Duration(seconds: 30),
//       backgroundColor: Colors.orange,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(processingSnackbar);

//     try {
//       final file = File(pickedFile.path);
      
//       // 2. Define Storage path and Upload
//       final fileName = pickedFile.name;
//       final ref = _firebaseStorage.ref()
//           .child('contractor_posts')
//           .child(userId)
//           .child(fileName + '_${DateTime.now().millisecondsSinceEpoch}');

//       final UploadTask uploadTask = ref.putFile(file);
//       final TaskSnapshot snapshot = await uploadTask;
//       final String downloadUrl = await snapshot.ref.getDownloadURL();

//       // 3. Update Firestore with the new post URL
//       await _firestore.collection('contractors').doc(userId).update({
//         'postUrls': FieldValue.arrayUnion([downloadUrl]),
//       });

//       // Hide processing and show success
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Post added and profile updated!')),
//       );

//     } catch (e) {
//       // Hide processing and show error
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to upload post: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userId = _auth.currentUser?.uid;

//     if (userId == null) {
//       return _buildLoginPrompt();
//     }

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 233, 234, 232),
//       body: StreamBuilder<ContractorProfile?>(
//         stream: contractorDataStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           if (!snapshot.hasData || snapshot.data == null) {
//             return _buildNoData();
//           }

//           final profileData = snapshot.data!;
//           return _buildProfileWithData(profileData);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _handleAddPost,
//         icon: const Icon(Icons.add_a_photo_outlined),
//         label: const Text('Add Post'),
//         backgroundColor: const Color.fromARGB(255, 90, 161, 75),
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
//     );
//   }

//   Widget _buildLoginPrompt() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.person_off, size: 60, color: Colors.grey),
//           const SizedBox(height: 16),
//           const Text("Please login to view contractor profile"),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               // Add your login navigation here
//             },
//             child: const Text("Login"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNoData() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.error_outline, size: 60, color: Colors.grey),
//           const SizedBox(height: 16),
//           const Text("No contractor profile data found"),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileWithData(ContractorProfile profileData) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           _buildProfileHeader(context, profileData),
//           const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
//           _buildAboutUsSection(profileData),
//           const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
//           _buildContactInfoSection(profileData),
//           const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Recent Projects & Media',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           if (profileData.postUrls.isNotEmpty)
//             _buildPostsGrid(context, profileData)
//           else
//             _buildNoPostsPlaceholder(),
//           const SizedBox(height: 80),
//         ],
//       ),
//     );
//   }

//   // UPDATED: Use profileData.coverUrl for the cover image
//   Widget _buildProfileHeader(BuildContext context, ContractorProfile profileData) {
//     const double coverHeight = 180.0;
//     const double profilePictureRadius = 50.0;
//     const double stackHeight = coverHeight + profilePictureRadius;
    
//     // Helper to get the cover image
//     ImageProvider _getCoverImage(String? imageUrl) {
//       if (imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
//         return NetworkImage(imageUrl);
//       } else {
//         // Fallback to a default network image
//         return const NetworkImage("https://placehold.co/600x400/388E3C/ffffff?text=Contractor+Cover");
//       }
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: stackHeight,
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               // Cover Image - NOW uses profileData.coverUrl
//               Container(
//                 height: coverHeight,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                   image: DecorationImage(
//                     image: _getCoverImage(profileData.coverUrl), // Use new coverUrl field
//                     fit: BoxFit.cover,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(20),
//                     ),
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.0),
//                         Colors.black.withOpacity(0.2),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               // Profile Picture and Edit Button
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       // Profile Picture with white border/ring
//                       Container(
//                         padding: const EdgeInsets.all(4.0),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                         ),
//                         child: CircleAvatar(
//                           radius: profilePictureRadius,
//                           backgroundColor: Colors.grey.shade200,
//                           backgroundImage: _getProfileImage(profileData.profileImage),
//                         ),
//                       ),

//                       // Edit Icon Button - UPDATED: Passes the correct callback
//                       Positioned(
//                         right: 0,
//                         bottom: 0,
//                         child: GestureDetector(
//                           onTap: () {
//                             // Pass the current profile data and the refresh callback
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => EditContractorProfile(
//                                   currentProfile: profileData,
//                                   onProfileUpdated: _refreshProfile, // Use the defined refresh function
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: const Color.fromARGB(255, 90, 161, 75),
//                               border: Border.all(
//                                 color: Theme.of(context).scaffoldBackgroundColor,
//                                 width: 3,
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.edit,
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 16),
//         Text(
//           profileData.name, // Dynamic name
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w800,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.phone, size: 18, color: Colors.blueGrey.shade400),
//             const SizedBox(width: 4),
//             Text(
//               profileData.phoneNo, // Dynamic phone (from data['mobile'])
//               style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
//             ),
//             const SizedBox(width: 16),
//             const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
//             const SizedBox(width: 4),
//             Text(
//               '${profileData.rating.toStringAsFixed(1)} Rating', // Dynamic rating
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF333333),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   ImageProvider _getProfileImage(String? imageUrl) {
//     if (imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
//       return NetworkImage(imageUrl);
//     } else {
//       // Fallback to a default network image or asset
//       return const NetworkImage("https://placehold.co/100x100/007AFF/ffffff?text=Profile");
//     }
//   }

//   // The rest of the _build sections remain the same...
//   Widget _buildAboutUsSection(ContractorProfile profileData) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'About Us',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.blueGrey.shade50,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               profileData.bio, // Dynamic bio
//               style: TextStyle(
//                 fontSize: 16,
//                 height: 1.4,
//                 color: Colors.blueGrey.shade800,
//               ),
//               textAlign: TextAlign.justify,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContactInfoSection(ContractorProfile profileData) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Contact Information',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.blueGrey.shade50,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               children: [
//                 if (profileData.email != null && profileData.email!.isNotEmpty)
//                   _buildContactRow(Icons.email, 'Email', profileData.email!), // Dynamic email
//                 if (profileData.phoneNo.isNotEmpty)
//                   _buildContactRow(Icons.phone, 'Phone', profileData.phoneNo), // Dynamic phone
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContactRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(icon, color: const Color.fromARGB(255, 90, 161, 75), size: 20),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // <<< MODIFIED: Added GestureDetector to enable tapping and viewing >>>
//   Widget _buildPostsGrid(BuildContext context, ContractorProfile profileData) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 4.0,
//           mainAxisSpacing: 4.0,
//           childAspectRatio: 1.0,
//         ),
//         itemCount: profileData.postUrls.length, // Dynamic post count
//         itemBuilder: (context, index) {
//           final url = profileData.postUrls[index]; // Dynamic post URL
          
//           // Simple heuristic to show video icon if the index is odd (Replace with actual file type checking if available)
//           final isVideo = index % 2 == 1; 

//           return GestureDetector(
//             onTap: () {
//               // Navigate to the full screen viewer
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => FullScreenPostViewer(postUrl: url, isVideo: isVideo),
//                 ),
//               );
//             },
//             child: AspectRatio(
//               aspectRatio: 1.0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.grey.shade200,
//                   image: DecorationImage(
//                     image: NetworkImage(url),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: isVideo
//                     ? const Align(
//                         alignment: Alignment.bottomRight,
//                         child: Padding(
//                           padding: EdgeInsets.all(4.0),
//                           child: Icon(
//                             Icons.videocam,
//                             color: Colors.white,
//                             size: 24,
//                             shadows: [Shadow(color: Colors.black, blurRadius: 4)],
//                           ),
//                         ),
//                       )
//                     : null,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildNoPostsPlaceholder() {
//     return const Center(
//       child: Padding(
//         padding: EdgeInsets.all(32.0),
//         child: Column(
//           children: [
//             Icon(Icons.photo_library_outlined, size: 40, color: Colors.grey),
//             SizedBox(height: 8),
//             Text(
//               "No projects posted yet.",
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             Text(
//               "Tap 'Add Post' to showcase your work!",
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }












// // // lib/View/Contractor/Contractor_Profile.dart

// // import 'dart:io'; // Required for File handling

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart'; // <<< NEW: Import Firebase Storage
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart'; // <<< NEW: Import Image Picker

// // import 'package:lansio/View/Contractor/Edit_Contractor_Profile.dart';

// // // --- Profile Data Model ---
// // class ContractorProfile {
// //   final String name;
// //   final String phoneNo; // Note: This field will hold data['mobile'] from Firestore
// //   final double rating;
// //   final String bio;
// //   final List<String> postUrls;
// //   final String? profileImage; // This is the profile picture URL
// //   final String? coverUrl;     // <<< NEW: Cover Image URL
// //   final String? email;
// //   final String? mobile;

// //   const ContractorProfile({
// //     required this.name,
// //     required this.phoneNo,
// //     required this.rating,
// //     required this.bio,
// //     required this.postUrls,
// //     this.profileImage,
// //     this.coverUrl,     // <<< NEW: Add to constructor
// //     this.email,
// //     this.mobile,
// //   });

// //   // Factory constructor to create from Firestore data
// //   factory ContractorProfile.fromFirestore(Map<String, dynamic> data) {
// //     return ContractorProfile(
// //       name: data['name'] ?? 'Contractor Name Not Set',
// //       phoneNo: data['mobile'] ?? 'Phone not set', // Use dynamic data['mobile'] for the primary phone display
// //       rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
// //       bio: data['bio'] ?? 'No bio available. Please edit your profile to add one.', // Maps to 'bio'
// //       postUrls: List<String>.from(data['postUrls'] ?? []),
// //       profileImage: data['profileImage'], // Maps to 'profileImage'
// //       coverUrl: data['coverUrl'],       // <<< NEW: Read 'coverUrl' from data
// //       email: data['email'],
// //       mobile: data['mobile'],
// //     );
// //   }

// //   // A helper method for creating an editable copy (used for forms)
// //   ContractorProfile copyWith({
// //     String? name,
// //     String? phoneNo,
// //     double? rating,
// //     String? bio,
// //     List<String>? postUrls,
// //     String? profileImage,
// //     String? coverUrl,       // <<< NEW: Add to copyWith
// //     String? email,
// //     String? mobile,
// //   }) {
// //     return ContractorProfile(
// //       name: name ?? this.name,
// //       phoneNo: phoneNo ?? this.phoneNo,
// //       rating: rating ?? this.rating,
// //       bio: bio ?? this.bio,
// //       postUrls: postUrls ?? this.postUrls,
// //       profileImage: profileImage ?? this.profileImage,
// //       coverUrl: coverUrl ?? this.coverUrl, // <<< NEW: Copy coverUrl
// //       email: email ?? this.email,
// //       mobile: mobile ?? this.mobile,
// //     );
// //   }
// // }

// // // --- The Main Profile Screen Widget (Stateful to allow updates) ---
// // class ContractorProfileScreen extends StatefulWidget {
// //   const ContractorProfileScreen({super.key});

// //   @override
// //   State<ContractorProfileScreen> createState() =>
// //       _ContractorProfileScreenState();
// // }

// // class _ContractorProfileScreenState extends State<ContractorProfileScreen> {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance; // <<< NEW: Instance for Storage

// //   // Real-time stream for contractor data (Reads from 'contractors' collection)
// //   Stream<ContractorProfile?> get contractorDataStream {
// //     final userId = _auth.currentUser?.uid;
// //     if (userId == null) return Stream.value(null);

// //     return _firestore.collection('contractors').doc(userId).snapshots().map((
// //       snapshot,
// //     ) {
// //       if (snapshot.exists && snapshot.data() != null) {
// //         return ContractorProfile.fromFirestore(snapshot.data()!);
// //       }
// //       return null;
// //     });
// //   }

// //   // Use this function to refresh the screen after an update
// //   void _refreshProfile(ContractorProfile updatedProfile) {
// //     // The StreamBuilder handles the refresh automatically, but this method
// //     // ensures the navigation in the Edit screen can call back to the parent.
// //     setState(() {
// //       // The stream will reload the latest data, so we just trigger a rebuild.
// //     });
// //   }

// //   // <<< MODIFIED: This is the only function changed to implement the feature >>>
// //   void _handleAddPost() async {
// //     final userId = _auth.currentUser?.uid;
// //     if (userId == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Please log in to add a post.')),
// //       );
// //       return;
// //     }

// //     // 1. Pick Image or Video
// //     final ImagePicker picker = ImagePicker();
// //     // Allows picking a single image or video from the gallery
// //     final XFile? pickedFile = await picker.pickMedia(
// //       // The following line is optional but helps with performance
// //       imageQuality: 70, 
// //     );

// //     if (pickedFile == null) return; // User cancelled the picker

// //     try {
// //       // Show loading indicator
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Uploading post...')),
// //       );

// //       final file = File(pickedFile.path);
      
// //       // 2. Define Storage path and Upload
// //       final fileName = pickedFile.name;
// //       final ref = _firebaseStorage.ref()
// //           .child('contractor_posts')
// //           .child(userId)
// //           .child(fileName + '_${DateTime.now().millisecondsSinceEpoch}');

// //       final UploadTask uploadTask = ref.putFile(file);
// //       final TaskSnapshot snapshot = await uploadTask;
// //       final String downloadUrl = await snapshot.ref.getDownloadURL();

// //       // 3. Update Firestore with the new post URL
// //       await _firestore.collection('contractors').doc(userId).update({
// //         'postUrls': FieldValue.arrayUnion([downloadUrl]),
// //       });

// //       // Show success message
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Post added and profile updated!')),
// //       );

// //     } catch (e) {
// //       // Show error message
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Failed to upload post: $e')),
// //       );
// //     }
// //   }
// //   // <<< END MODIFIED FUNCTION >>>

// //   @override
// //   Widget build(BuildContext context) {
// //     final userId = _auth.currentUser?.uid;

// //     if (userId == null) {
// //       return _buildLoginPrompt();
// //     }

// //     return Scaffold(
// //       backgroundColor: const Color.fromARGB(255, 233, 234, 232),
// //       body: StreamBuilder<ContractorProfile?>(
// //         stream: contractorDataStream,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(
// //               child: Text('Error: ${snapshot.error}'),
// //             );
// //           }

// //           if (!snapshot.hasData || snapshot.data == null) {
// //             return _buildNoData();
// //           }

// //           final profileData = snapshot.data!;
// //           return _buildProfileWithData(profileData);
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton.extended(
// //         onPressed: _handleAddPost,
// //         icon: const Icon(Icons.add_a_photo_outlined),
// //         label: const Text('Add Post'),
// //         backgroundColor: const Color.fromARGB(255, 90, 161, 75),
// //         foregroundColor: Colors.white,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
// //     );
// //   }

// //   Widget _buildLoginPrompt() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           const Icon(Icons.person_off, size: 60, color: Colors.grey),
// //           const SizedBox(height: 16),
// //           const Text("Please login to view contractor profile"),
// //           const SizedBox(height: 16),
// //           ElevatedButton(
// //             onPressed: () {
// //               // Add your login navigation here
// //             },
// //             child: const Text("Login"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildNoData() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           const Icon(Icons.error_outline, size: 60, color: Colors.grey),
// //           const SizedBox(height: 16),
// //           const Text("No contractor profile data found"),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildProfileWithData(ContractorProfile profileData) {
// //     return SingleChildScrollView(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: <Widget>[
// //           _buildProfileHeader(context, profileData),
// //           const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
// //           _buildAboutUsSection(profileData),
// //           const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
// //           _buildContactInfoSection(profileData),
// //           const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
// //           const Padding(
// //             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// //             child: Align(
// //               alignment: Alignment.centerLeft,
// //               child: Text(
// //                 'Recent Projects & Media',
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //           ),
// //           if (profileData.postUrls.isNotEmpty)
// //             _buildPostsGrid(context, profileData)
// //           else
// //             _buildNoPostsPlaceholder(),
// //           const SizedBox(height: 80),
// //         ],
// //       ),
// //     );
// //   }

// //   // UPDATED: Use profileData.coverUrl for the cover image
// //   Widget _buildProfileHeader(BuildContext context, ContractorProfile profileData) {
// //     const double coverHeight = 180.0;
// //     const double profilePictureRadius = 50.0;
// //     const double stackHeight = coverHeight + profilePictureRadius;
    
// //     // Helper to get the cover image
// //     ImageProvider _getCoverImage(String? imageUrl) {
// //       if (imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
// //         return NetworkImage(imageUrl);
// //       } else {
// //         // Fallback to a default network image
// //         return const NetworkImage("https://placehold.co/600x400/388E3C/ffffff?text=Contractor+Cover");
// //       }
// //     }

// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         SizedBox(
// //           height: stackHeight,
// //           child: Stack(
// //             clipBehavior: Clip.none,
// //             children: [
// //               // Cover Image - NOW uses profileData.coverUrl
// //               Container(
// //                 height: coverHeight,
// //                 width: double.infinity,
// //                 decoration: BoxDecoration(
// //                   borderRadius: const BorderRadius.only(
// //                     bottomLeft: Radius.circular(20),
// //                     bottomRight: Radius.circular(20),
// //                   ),
// //                   image: DecorationImage(
// //                     image: _getCoverImage(profileData.coverUrl), // Use new coverUrl field
// //                     fit: BoxFit.cover,
// //                   ),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.1),
// //                       blurRadius: 10,
// //                       offset: const Offset(0, 5),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     borderRadius: const BorderRadius.only(
// //                       bottomLeft: Radius.circular(20),
// //                       bottomRight: Radius.circular(20),
// //                     ),
// //                     gradient: LinearGradient(
// //                       begin: Alignment.topCenter,
// //                       end: Alignment.bottomCenter,
// //                       colors: [
// //                         Colors.black.withOpacity(0.0),
// //                         Colors.black.withOpacity(0.2),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               // Profile Picture and Edit Button
// //               Positioned(
// //                 bottom: 0,
// //                 left: 0,
// //                 right: 0,
// //                 child: Center(
// //                   child: Stack(
// //                     clipBehavior: Clip.none,
// //                     children: [
// //                       // Profile Picture with white border/ring
// //                       Container(
// //                         padding: const EdgeInsets.all(4.0),
// //                         decoration: BoxDecoration(
// //                           shape: BoxShape.circle,
// //                           color: Theme.of(context).scaffoldBackgroundColor,
// //                         ),
// //                         child: CircleAvatar(
// //                           radius: profilePictureRadius,
// //                           backgroundColor: Colors.grey.shade200,
// //                           backgroundImage: _getProfileImage(profileData.profileImage),
// //                         ),
// //                       ),

// //                       // Edit Icon Button - UPDATED: Passes the correct callback
// //                       Positioned(
// //                         right: 0,
// //                         bottom: 0,
// //                         child: GestureDetector(
// //                           onTap: () {
// //                             // Pass the current profile data and the refresh callback
// //                             Navigator.of(context).push(
// //                               MaterialPageRoute(
// //                                 builder: (context) => EditContractorProfile(
// //                                   currentProfile: profileData,
// //                                   onProfileUpdated: _refreshProfile, // Use the defined refresh function
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                           child: Container(
// //                             padding: const EdgeInsets.all(4),
// //                             decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               color: const Color.fromARGB(255, 90, 161, 75),
// //                               border: Border.all(
// //                                 color: Theme.of(context).scaffoldBackgroundColor,
// //                                 width: 3,
// //                               ),
// //                             ),
// //                             child: const Icon(
// //                               Icons.edit,
// //                               color: Colors.white,
// //                               size: 18,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),

// //         const SizedBox(height: 16),
// //         Text(
// //           profileData.name, // Dynamic name
// //           style: const TextStyle(
// //             fontSize: 24,
// //             fontWeight: FontWeight.w800,
// //             color: Color(0xFF333333),
// //           ),
// //         ),
// //         const SizedBox(height: 8),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(Icons.phone, size: 18, color: Colors.blueGrey.shade400),
// //             const SizedBox(width: 4),
// //             Text(
// //               profileData.phoneNo, // Dynamic phone (from data['mobile'])
// //               style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
// //             ),
// //             const SizedBox(width: 16),
// //             const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
// //             const SizedBox(width: 4),
// //             Text(
// //               '${profileData.rating.toStringAsFixed(1)} Rating', // Dynamic rating
// //               style: const TextStyle(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.w600,
// //                 color: Color(0xFF333333),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 24),
// //       ],
// //     );
// //   }

// //   ImageProvider _getProfileImage(String? imageUrl) {
// //     if (imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
// //       return NetworkImage(imageUrl);
// //     } else {
// //       // Fallback to a default network image or asset
// //       return const NetworkImage("https://placehold.co/100x100/007AFF/ffffff?text=Profile");
// //     }
// //   }

// //   // The rest of the _build sections remain the same...
// //   Widget _buildAboutUsSection(ContractorProfile profileData) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             'About Us',
// //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(height: 8),
// //           Container(
// //             padding: const EdgeInsets.all(12),
// //             decoration: BoxDecoration(
// //               color: Colors.blueGrey.shade50,
// //               borderRadius: BorderRadius.circular(12),
// //             ),
// //             child: Text(
// //               profileData.bio, // Dynamic bio
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 height: 1.4,
// //                 color: Colors.blueGrey.shade800,
// //               ),
// //               textAlign: TextAlign.justify,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildContactInfoSection(ContractorProfile profileData) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             'Contact Information',
// //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(height: 8),
// //           Container(
// //             padding: const EdgeInsets.all(12),
// //             decoration: BoxDecoration(
// //               color: Colors.blueGrey.shade50,
// //               borderRadius: BorderRadius.circular(12),
// //             ),
// //             child: Column(
// //               children: [
// //                 if (profileData.email != null && profileData.email!.isNotEmpty)
// //                   _buildContactRow(Icons.email, 'Email', profileData.email!), // Dynamic email
// //                 if (profileData.phoneNo.isNotEmpty)
// //                   _buildContactRow(Icons.phone, 'Phone', profileData.phoneNo), // Dynamic phone
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildContactRow(IconData icon, String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// //       child: Row(
// //         children: [
// //           Icon(icon, color: const Color.fromARGB(255, 90, 161, 75), size: 20),
// //           const SizedBox(width: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   label,
// //                   style: const TextStyle(fontSize: 14, color: Colors.grey),
// //                 ),
// //                 Text(
// //                   value,
// //                   style: const TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildPostsGrid(BuildContext context, ContractorProfile profileData) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //       child: GridView.builder(
// //         shrinkWrap: true,
// //         physics: const NeverScrollableScrollPhysics(),
// //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 3,
// //           crossAxisSpacing: 4.0,
// //           mainAxisSpacing: 4.0,
// //           childAspectRatio: 1.0,
// //         ),
// //         itemCount: profileData.postUrls.length, // Dynamic post count
// //         itemBuilder: (context, index) {
// //           final url = profileData.postUrls[index]; // Dynamic post URL
          
// //           // Simple heuristic to show video icon if the index is odd (Replace with actual file type checking if available)
// //           final isVideo = index % 2 == 1; 

// //           return AspectRatio(
// //             aspectRatio: 1.0,
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(8),
// //                 color: Colors.grey.shade200,
// //                 image: DecorationImage(
// //                   image: NetworkImage(url),
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //               child: isVideo
// //                   ? const Align(
// //                       alignment: Alignment.bottomRight,
// //                       child: Padding(
// //                         padding: EdgeInsets.all(4.0),
// //                         child: Icon(
// //                           Icons.videocam,
// //                           color: Colors.white,
// //                           size: 24,
// //                           shadows: [Shadow(color: Colors.black, blurRadius: 4)],
// //                         ),
// //                       ),
// //                     )
// //                   : null,
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildNoPostsPlaceholder() {
// //     return const Center(
// //       child: Padding(
// //         padding: EdgeInsets.all(32.0),
// //         child: Column(
// //           children: [
// //             Icon(Icons.photo_library_outlined, size: 40, color: Colors.grey),
// //             SizedBox(height: 8),
// //             Text(
// //               "No projects posted yet.",
// //               style: TextStyle(fontSize: 16, color: Colors.grey),
// //             ),
// //             Text(
// //               "Tap 'Add Post' to showcase your work!",
// //               style: TextStyle(fontSize: 16, color: Colors.grey),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }



// // // // lib/View/Contractor/Contractor_Profile.dart

// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/material.dart';

// // // import 'package:lansio/View/Contractor/Edit_Contractor_Profile.dart';

// // // // --- Profile Data Model ---
// // // class ContractorProfile {
// // //   final String name;
// // //   final String phoneNo; // Note: This field will hold data['mobile'] from Firestore
// // //   final double rating;
// // //   final String bio;
// // //   final List<String> postUrls;
// // //   final String? profileImage; // This is the profile picture URL
// // //   final String? coverUrl;     // <<< NEW: Cover Image URL
// // //   final String? email;
// // //   final String? mobile;

// // //   const ContractorProfile({
// // //     required this.name,
// // //     required this.phoneNo,
// // //     required this.rating,
// // //     required this.bio,
// // //     required this.postUrls,
// // //     this.profileImage,
// // //     this.coverUrl,     // <<< NEW: Add to constructor
// // //     this.email,
// // //     this.mobile,
// // //   });

// // //   // Factory constructor to create from Firestore data
// // //   factory ContractorProfile.fromFirestore(Map<String, dynamic> data) {
// // //     return ContractorProfile(
// // //       name: data['name'] ?? 'Contractor Name Not Set',
// // //       phoneNo: data['mobile'] ?? 'Phone not set', // Use dynamic data['mobile'] for the primary phone display
// // //       rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
// // //       bio: data['bio'] ?? 'No bio available. Please edit your profile to add one.', // Maps to 'bio'
// // //       postUrls: List<String>.from(data['postUrls'] ?? []),
// // //       profileImage: data['profileImage'], // Maps to 'profileImage'
// // //       coverUrl: data['coverUrl'],       // <<< NEW: Read 'coverUrl' from data
// // //       email: data['email'],
// // //       mobile: data['mobile'],
// // //     );
// // //   }

// // //   // A helper method for creating an editable copy (used for forms)
// // //   ContractorProfile copyWith({
// // //     String? name,
// // //     String? phoneNo,
// // //     double? rating,
// // //     String? bio,
// // //     List<String>? postUrls,
// // //     String? profileImage,
// // //     String? coverUrl,      // <<< NEW: Add to copyWith
// // //     String? email,
// // //     String? mobile,
// // //   }) {
// // //     return ContractorProfile(
// // //       name: name ?? this.name,
// // //       phoneNo: phoneNo ?? this.phoneNo,
// // //       rating: rating ?? this.rating,
// // //       bio: bio ?? this.bio,
// // //       postUrls: postUrls ?? this.postUrls,
// // //       profileImage: profileImage ?? this.profileImage,
// // //       coverUrl: coverUrl ?? this.coverUrl, // <<< NEW: Copy coverUrl
// // //       email: email ?? this.email,
// // //       mobile: mobile ?? this.mobile,
// // //     );
// // //   }
// // // }

// // // // --- The Main Profile Screen Widget (Stateful to allow updates) ---
// // // class ContractorProfileScreen extends StatefulWidget {
// // //   const ContractorProfileScreen({super.key});

// // //   @override
// // //   State<ContractorProfileScreen> createState() =>
// // //       _ContractorProfileScreenState();
// // // }

// // // class _ContractorProfileScreenState extends State<ContractorProfileScreen> {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // //   // Real-time stream for contractor data (Reads from 'contractors' collection)
// // //   Stream<ContractorProfile?> get contractorDataStream {
// // //     final userId = _auth.currentUser?.uid;
// // //     if (userId == null) return Stream.value(null);

// // //     return _firestore.collection('contractors').doc(userId).snapshots().map((
// // //       snapshot,
// // //     ) {
// // //       if (snapshot.exists && snapshot.data() != null) {
// // //         return ContractorProfile.fromFirestore(snapshot.data()!);
// // //       }
// // //       return null;
// // //     });
// // //   }

// // //   // Use this function to refresh the screen after an update
// // //   void _refreshProfile(ContractorProfile updatedProfile) {
// // //     // The StreamBuilder handles the refresh automatically, but this method
// // //     // ensures the navigation in the Edit screen can call back to the parent.
// // //     setState(() {
// // //       // The stream will reload the latest data, so we just trigger a rebuild.
// // //     });
// // //   }

// // //   void _handleAddPost() {
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       const SnackBar(content: Text('Add Post functionality will be implemented')),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final userId = _auth.currentUser?.uid;

// // //     if (userId == null) {
// // //       return _buildLoginPrompt();
// // //     }

// // //     return Scaffold(
// // //       backgroundColor: const Color.fromARGB(255, 233, 234, 232),
// // //       body: StreamBuilder<ContractorProfile?>(
// // //         stream: contractorDataStream,
// // //         builder: (context, snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return const Center(child: CircularProgressIndicator());
// // //           }

// // //           if (snapshot.hasError) {
// // //             return Center(
// // //               child: Text('Error: ${snapshot.error}'),
// // //             );
// // //           }

// // //           if (!snapshot.hasData || snapshot.data == null) {
// // //             return _buildNoData();
// // //           }

// // //           final profileData = snapshot.data!;
// // //           return _buildProfileWithData(profileData);
// // //         },
// // //       ),
// // //       floatingActionButton: FloatingActionButton.extended(
// // //         onPressed: _handleAddPost,
// // //         icon: const Icon(Icons.add_a_photo_outlined),
// // //         label: const Text('Add Post'),
// // //         backgroundColor: const Color.fromARGB(255, 90, 161, 75),
// // //         foregroundColor: Colors.white,
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // //       ),
// // //       floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
// // //     );
// // //   }

// // //   Widget _buildLoginPrompt() {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           const Icon(Icons.person_off, size: 60, color: Colors.grey),
// // //           const SizedBox(height: 16),
// // //           const Text("Please login to view contractor profile"),
// // //           const SizedBox(height: 16),
// // //           ElevatedButton(
// // //             onPressed: () {
// // //               // Add your login navigation here
// // //             },
// // //             child: const Text("Login"),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildNoData() {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           const Icon(Icons.error_outline, size: 60, color: Colors.grey),
// // //           const SizedBox(height: 16),
// // //           const Text("No contractor profile data found"),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildProfileWithData(ContractorProfile profileData) {
// // //     return SingleChildScrollView(
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.center,
// // //         children: <Widget>[
// // //           _buildProfileHeader(context, profileData),
// // //           const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
// // //           _buildAboutUsSection(profileData),
// // //           const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
// // //           _buildContactInfoSection(profileData),
// // //           const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
// // //           const Padding(
// // //             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// // //             child: Align(
// // //               alignment: Alignment.centerLeft,
// // //               child: Text(
// // //                 'Recent Projects & Media',
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //             ),
// // //           ),
// // //           if (profileData.postUrls.isNotEmpty)
// // //             _buildPostsGrid(context, profileData)
// // //           else
// // //             _buildNoPostsPlaceholder(),
// // //           const SizedBox(height: 80),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // UPDATED: Use profileData.coverUrl for the cover image
// // //   Widget _buildProfileHeader(BuildContext context, ContractorProfile profileData) {
// // //     const double coverHeight = 180.0;
// // //     const double profilePictureRadius = 50.0;
// // //     const double stackHeight = coverHeight + profilePictureRadius;
    
// // //     // Helper to get the cover image
// // //     ImageProvider _getCoverImage(String? imageUrl) {
// // //       if (imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
// // //         return NetworkImage(imageUrl);
// // //       } else {
// // //         // Fallback to a default network image
// // //         return const NetworkImage("https://placehold.co/600x400/388E3C/ffffff?text=Contractor+Cover");
// // //       }
// // //     }

// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.center,
// // //       children: [
// // //         SizedBox(
// // //           height: stackHeight,
// // //           child: Stack(
// // //             clipBehavior: Clip.none,
// // //             children: [
// // //               // Cover Image - NOW uses profileData.coverUrl
// // //               Container(
// // //                 height: coverHeight,
// // //                 width: double.infinity,
// // //                 decoration: BoxDecoration(
// // //                   borderRadius: const BorderRadius.only(
// // //                     bottomLeft: Radius.circular(20),
// // //                     bottomRight: Radius.circular(20),
// // //                   ),
// // //                   image: DecorationImage(
// // //                     image: _getCoverImage(profileData.coverUrl), // Use new coverUrl field
// // //                     fit: BoxFit.cover,
// // //                   ),
// // //                   boxShadow: [
// // //                     BoxShadow(
// // //                       color: Colors.black.withOpacity(0.1),
// // //                       blurRadius: 10,
// // //                       offset: const Offset(0, 5),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 child: Container(
// // //                   decoration: BoxDecoration(
// // //                     borderRadius: const BorderRadius.only(
// // //                       bottomLeft: Radius.circular(20),
// // //                       bottomRight: Radius.circular(20),
// // //                     ),
// // //                     gradient: LinearGradient(
// // //                       begin: Alignment.topCenter,
// // //                       end: Alignment.bottomCenter,
// // //                       colors: [
// // //                         Colors.black.withOpacity(0.0),
// // //                         Colors.black.withOpacity(0.2),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),

// // //               // Profile Picture and Edit Button
// // //               Positioned(
// // //                 bottom: 0,
// // //                 left: 0,
// // //                 right: 0,
// // //                 child: Center(
// // //                   child: Stack(
// // //                     clipBehavior: Clip.none,
// // //                     children: [
// // //                       // Profile Picture with white border/ring
// // //                       Container(
// // //                         padding: const EdgeInsets.all(4.0),
// // //                         decoration: BoxDecoration(
// // //                           shape: BoxShape.circle,
// // //                           color: Theme.of(context).scaffoldBackgroundColor,
// // //                         ),
// // //                         child: CircleAvatar(
// // //                           radius: profilePictureRadius,
// // //                           backgroundColor: Colors.grey.shade200,
// // //                           backgroundImage: _getProfileImage(profileData.profileImage),
// // //                         ),
// // //                       ),

// // //                       // Edit Icon Button - UPDATED: Passes the correct callback
// // //                       Positioned(
// // //                         right: 0,
// // //                         bottom: 0,
// // //                         child: GestureDetector(
// // //                           onTap: () {
// // //                             // Pass the current profile data and the refresh callback
// // //                             Navigator.of(context).push(
// // //                               MaterialPageRoute(
// // //                                 builder: (context) => EditContractorProfile(
// // //                                   currentProfile: profileData,
// // //                                   onProfileUpdated: _refreshProfile, // Use the defined refresh function
// // //                                 ),
// // //                               ),
// // //                             );
// // //                           },
// // //                           child: Container(
// // //                             padding: const EdgeInsets.all(4),
// // //                             decoration: BoxDecoration(
// // //                               shape: BoxShape.circle,
// // //                               color: const Color.fromARGB(255, 90, 161, 75),
// // //                               border: Border.all(
// // //                                 color: Theme.of(context).scaffoldBackgroundColor,
// // //                                 width: 3,
// // //                               ),
// // //                             ),
// // //                             child: const Icon(
// // //                               Icons.edit,
// // //                               color: Colors.white,
// // //                               size: 18,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),

// // //         const SizedBox(height: 16),
// // //         Text(
// // //           profileData.name, // Dynamic name
// // //           style: const TextStyle(
// // //             fontSize: 24,
// // //             fontWeight: FontWeight.w800,
// // //             color: Color(0xFF333333),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 8),
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             Icon(Icons.phone, size: 18, color: Colors.blueGrey.shade400),
// // //             const SizedBox(width: 4),
// // //             Text(
// // //               profileData.phoneNo, // Dynamic phone (from data['mobile'])
// // //               style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
// // //             ),
// // //             const SizedBox(width: 16),
// // //             const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
// // //             const SizedBox(width: 4),
// // //             Text(
// // //               '${profileData.rating.toStringAsFixed(1)} Rating', // Dynamic rating
// // //               style: const TextStyle(
// // //                 fontSize: 16,
// // //                 fontWeight: FontWeight.w600,
// // //                 color: Color(0xFF333333),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 24),
// // //       ],
// // //     );
// // //   }

// // //   ImageProvider _getProfileImage(String? imageUrl) {
// // //     if (imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
// // //       return NetworkImage(imageUrl);
// // //     } else {
// // //       // Fallback to a default network image or asset
// // //       return const NetworkImage("https://placehold.co/100x100/007AFF/ffffff?text=Profile");
// // //     }
// // //   }

// // //   // The rest of the _build sections remain the same...
// // //   Widget _buildAboutUsSection(ContractorProfile profileData) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           const Text(
// // //             'About Us',
// // //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //           ),
// // //           const SizedBox(height: 8),
// // //           Container(
// // //             padding: const EdgeInsets.all(12),
// // //             decoration: BoxDecoration(
// // //               color: Colors.blueGrey.shade50,
// // //               borderRadius: BorderRadius.circular(12),
// // //             ),
// // //             child: Text(
// // //               profileData.bio, // Dynamic bio
// // //               style: TextStyle(
// // //                 fontSize: 16,
// // //                 height: 1.4,
// // //                 color: Colors.blueGrey.shade800,
// // //               ),
// // //               textAlign: TextAlign.justify,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildContactInfoSection(ContractorProfile profileData) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           const Text(
// // //             'Contact Information',
// // //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //           ),
// // //           const SizedBox(height: 8),
// // //           Container(
// // //             padding: const EdgeInsets.all(12),
// // //             decoration: BoxDecoration(
// // //               color: Colors.blueGrey.shade50,
// // //               borderRadius: BorderRadius.circular(12),
// // //             ),
// // //             child: Column(
// // //               children: [
// // //                 if (profileData.email != null && profileData.email!.isNotEmpty)
// // //                   _buildContactRow(Icons.email, 'Email', profileData.email!), // Dynamic email
// // //                 if (profileData.phoneNo.isNotEmpty)
// // //                   _buildContactRow(Icons.phone, 'Phone', profileData.phoneNo), // Dynamic phone
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildContactRow(IconData icon, String label, String value) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // //       child: Row(
// // //         children: [
// // //           Icon(icon, color: const Color.fromARGB(255, 90, 161, 75), size: 20),
// // //           const SizedBox(width: 12),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   label,
// // //                   style: const TextStyle(fontSize: 14, color: Colors.grey),
// // //                 ),
// // //                 Text(
// // //                   value,
// // //                   style: const TextStyle(
// // //                     fontSize: 16,
// // //                     fontWeight: FontWeight.w600,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildPostsGrid(BuildContext context, ContractorProfile profileData) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //       child: GridView.builder(
// // //         shrinkWrap: true,
// // //         physics: const NeverScrollableScrollPhysics(),
// // //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //           crossAxisCount: 3,
// // //           crossAxisSpacing: 4.0,
// // //           mainAxisSpacing: 4.0,
// // //           childAspectRatio: 1.0,
// // //         ),
// // //         itemCount: profileData.postUrls.length, // Dynamic post count
// // //         itemBuilder: (context, index) {
// // //           final url = profileData.postUrls[index]; // Dynamic post URL
// // //           return AspectRatio(
// // //             aspectRatio: 1.0,
// // //             child: Container(
// // //               decoration: BoxDecoration(
// // //                 borderRadius: BorderRadius.circular(8),
// // //                 color: Colors.grey.shade200,
// // //                 image: DecorationImage(
// // //                   image: NetworkImage(url),
// // //                   fit: BoxFit.cover,
// // //                 ),
// // //               ),
// // //               child: index % 2 == 1
// // //                   ? const Align(
// // //                       alignment: Alignment.bottomRight,
// // //                       child: Padding(
// // //                         padding: EdgeInsets.all(4.0),
// // //                         child: Icon(
// // //                           Icons.videocam,
// // //                           color: Colors.white,
// // //                           size: 24,
// // //                           shadows: [Shadow(color: Colors.black, blurRadius: 4)],
// // //                         ),
// // //                       ),
// // //                     )
// // //                   : null,
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildNoPostsPlaceholder() {
// // //     return const Center(
// // //       child: Padding(
// // //         padding: EdgeInsets.all(32.0),
// // //         child: Column(
// // //           children: [
// // //             Icon(Icons.photo_library_outlined, size: 40, color: Colors.grey),
// // //             SizedBox(height: 8),
// // //             Text(
// // //               "No projects posted yet.",
// // //               style: TextStyle(fontSize: 16, color: Colors.grey),
// // //             ),
// // //             Text(
// // //               "Tap 'Add Post' to showcase your work!",
// // //               style: TextStyle(fontSize: 16, color: Colors.grey),
// // //             ),
// // //           ],
// // //         ),
// // //     ),
// // // );
// // // }
// // // }









// lib/View/Contractor/Contractor_Profile.dart

import 'dart:io'; 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 

import 'package:lansio/View/Contractor/Edit_Contractor_Profile.dart';
import 'package:lansio/View/Contractor/FullScreenPostViewer.dart'; 

// --- Post Data Model (NEW: Encapsulate post data) ---
class ContractorPost { // <<< NEW: Helper class to hold post URL and type
  final String url;
  final bool isVideo;

  const ContractorPost({
    required this.url,
    required this.isVideo,
  });

  factory ContractorPost.fromMap(Map<String, dynamic> data) {
    return ContractorPost(
      url: data['url'] ?? '',
      isVideo: data['isVideo'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'isVideo': isVideo,
    };
  }
}

// --- Profile Data Model (MODIFIED: postUrls to store map data) ---
class ContractorProfile {
  final String name;
  final String phoneNo;
  final double rating;
  final String bio;
  final List<ContractorPost> posts; // <<< MODIFIED: List of ContractorPost objects
  final String? profileImage;
  final String? coverUrl;
  final String? email;
  final String? mobile;

  const ContractorProfile({
    required this.name,
    required this.phoneNo,
    required this.rating,
    required this.bio,
    required this.posts, // <<< MODIFIED
    this.profileImage,
    this.coverUrl,
    this.email,
    this.mobile,
  });

  // Factory constructor to create from Firestore data (MODIFIED)
  factory ContractorProfile.fromFirestore(Map<String, dynamic> data) {
    // Process list of maps into list of ContractorPost objects
    final List<dynamic> rawPosts = data['posts'] ?? [];
    final List<ContractorPost> parsedPosts = rawPosts
        .map((postMap) => ContractorPost.fromMap(postMap as Map<String, dynamic>))
        .toList();

    return ContractorProfile(
      name: data['name'] ?? 'Contractor Name Not Set',
      phoneNo: data['mobile'] ?? 'Phone not set', 
      rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
      bio: data['bio'] ?? 'No bio available. Please edit your profile to add one.',
      posts: parsedPosts, // <<< MODIFIED
      profileImage: data['profileImage'],
      coverUrl: data['coverUrl'],
      email: data['email'],
      mobile: data['mobile'],
    );
  }

  // A helper method for creating an editable copy (MODIFIED)
  ContractorProfile copyWith({
    String? name,
    String? phoneNo,
    double? rating,
    String? bio,
    List<ContractorPost>? posts, // <<< MODIFIED
    String? profileImage,
    String? coverUrl,
    String? email,
    String? mobile,
  }) {
    return ContractorProfile(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      rating: rating ?? this.rating,
      bio: bio ?? this.bio,
      posts: posts ?? this.posts, // <<< MODIFIED
      profileImage: profileImage ?? this.profileImage,
      coverUrl: coverUrl ?? this.coverUrl,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
    );
  }
}

// --- The Main Profile Screen Widget (Stateful to allow updates) ---
class ContractorProfileScreen extends StatefulWidget {
  const ContractorProfileScreen({super.key});

  @override
  State<ContractorProfileScreen> createState() =>
      _ContractorProfileScreenState();
}

class _ContractorProfileScreenState extends State<ContractorProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance; 

  // Real-time stream for contractor data 
  Stream<ContractorProfile?> get contractorDataStream {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value(null);

    return _firestore.collection('contractors').doc(userId).snapshots().map((
      snapshot,
    ) {
      if (snapshot.exists && snapshot.data() != null) {
        return ContractorProfile.fromFirestore(snapshot.data()!);
      }
      return null;
    });
  }

  void _refreshProfile(ContractorProfile updatedProfile) {
    setState(() {});
  }

  // <<< MODIFIED: Now saves file type (isVideo) along with URL >>>
  void _handleAddPost() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to add a post.')),
      );
      return;
    }

    // 1. Pick Image or Video
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickMedia(
      imageQuality: 70, // Optimize image size
    );

    if (pickedFile == null) return; // User cancelled

    // --- NEW: Determine if the selected file is a video ---
    // This is the correct way to distinguish the media type based on MIME type.
    final bool isVideo = pickedFile.mimeType?.startsWith('video/') ?? false; 
    // If mimeType is null (shouldn't happen with pickMedia), default to image (false)

    // Show a temporary indicator while processing
    final SnackBar processingSnackbar = const SnackBar(
      content: Text('Uploading post... Please wait.'),
      duration: Duration(seconds: 30),
      backgroundColor: Colors.orange,
    );
    ScaffoldMessenger.of(context).showSnackBar(processingSnackbar);

    try {
      final file = File(pickedFile.path);
      
      // 2. Define Storage path and Upload
      final fileName = pickedFile.name;
      final ref = _firebaseStorage.ref()
          .child('contractor_posts')
          .child(userId)
          .child(fileName + '_${DateTime.now().millisecondsSinceEpoch}');

      final UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // --- NEW: Prepare the post data map ---
      final newPostData = ContractorPost(url: downloadUrl, isVideo: isVideo).toMap();

      // 3. Update Firestore with the new post map
      await _firestore.collection('contractors').doc(userId).update({
        // 'posts' is the new field, replacing 'postUrls'
        'posts': FieldValue.arrayUnion([newPostData]), 
      });

      // Hide processing and show success
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post added and profile updated!')),
      );

    } catch (e) {
      // Hide processing and show error
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      return _buildLoginPrompt();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 234, 232),
      body: StreamBuilder<ContractorProfile?>(
        stream: contractorDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return _buildNoData();
          }

          final profileData = snapshot.data!;
          return _buildProfileWithData(profileData);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddPost,
        icon: const Icon(Icons.add_a_photo_outlined),
        label: const Text('Add Post'),
        backgroundColor: const Color.fromARGB(255, 90, 161, 75),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
  
  // ... (unchanged helper methods: _buildLoginPrompt, _buildNoData, _buildProfileWithData, _buildProfileHeader, _getCoverImage, _getProfileImage, _buildAboutUsSection, _buildContactInfoSection, _buildContactRow) ...

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_off, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          const Text("Please login to view contractor profile"),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Add your login navigation here
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }

  Widget _buildNoData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          const Text("No contractor profile data found"),
        ],
      ),
    );
  }

  Widget _buildProfileWithData(ContractorProfile profileData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildProfileHeader(context, profileData),
          const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
          _buildAboutUsSection(profileData),
          const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
          _buildContactInfoSection(profileData),
          const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Projects & Media',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (profileData.posts.isNotEmpty) // MODIFIED: Check against posts
            _buildPostsGrid(context, profileData)
          else
            _buildNoPostsPlaceholder(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  // UPDATED: Use profileData.coverUrl for the cover image
  Widget _buildProfileHeader(BuildContext context, ContractorProfile profileData) {
    const double coverHeight = 180.0;
    const double profilePictureRadius = 50.0;
    const double stackHeight = coverHeight + profilePictureRadius;
    
    // Helper to get the cover image
    ImageProvider _getCoverImage(String? imageUrl) {
      if (imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
        return NetworkImage(imageUrl);
      } else {
        // Fallback to a default network image
        return const NetworkImage("https://placehold.co/600x400/388E3C/ffffff?text=Contractor+Cover");
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: stackHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Cover Image - NOW uses profileData.coverUrl
              Container(
                height: coverHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: _getCoverImage(profileData.coverUrl), // Use new coverUrl field
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
              ),

              // Profile Picture and Edit Button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Profile Picture with white border/ring
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: CircleAvatar(
                          radius: profilePictureRadius,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: _getProfileImage(profileData.profileImage),
                        ),
                      ),

                      // Edit Icon Button - UPDATED: Passes the correct callback
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Pass the current profile data and the refresh callback
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditContractorProfile(
                                  currentProfile: profileData,
                                  onProfileUpdated: _refreshProfile, // Use the defined refresh function
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(255, 90, 161, 75),
                              border: Border.all(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
        Text(
          profileData.name, // Dynamic name
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone, size: 18, color: Colors.blueGrey.shade400),
            const SizedBox(width: 4),
            Text(
              profileData.phoneNo, // Dynamic phone (from data['mobile'])
              style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              '${profileData.rating.toStringAsFixed(1)} Rating', // Dynamic rating
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  ImageProvider _getProfileImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else {
      // Fallback to a default network image or asset
      return const NetworkImage("https://placehold.co/100x100/007AFF/ffffff?text=Profile");
    }
  }

  // The rest of the _build sections remain the same...
  Widget _buildAboutUsSection(ContractorProfile profileData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Us',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              profileData.bio, // Dynamic bio
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Colors.blueGrey.shade800,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoSection(ContractorProfile profileData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                if (profileData.email != null && profileData.email!.isNotEmpty)
                  _buildContactRow(Icons.email, 'Email', profileData.email!), // Dynamic email
                if (profileData.phoneNo.isNotEmpty)
                  _buildContactRow(Icons.phone, 'Phone', profileData.phoneNo), // Dynamic phone
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 90, 161, 75), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // <<< MODIFIED: Uses the stored 'isVideo' property from ContractorPost >>>
  Widget _buildPostsGrid(BuildContext context, ContractorProfile profileData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          childAspectRatio: 1.0,
        ),
        itemCount: profileData.posts.length, // MODIFIED: Use posts list
        itemBuilder: (context, index) {
          final post = profileData.posts[index]; // NEW: Get ContractorPost object
          final url = post.url;
          final isVideo = post.isVideo; // <<< CORRECT LOGIC: Use the stored type

          return GestureDetector(
            onTap: () {
              // Navigate to the full screen viewer
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FullScreenPostViewer(postUrl: url, isVideo: isVideo),
                ),
              );
            },
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
                child: isVideo
                    ? const Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 24,
                            shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoPostsPlaceholder() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(Icons.photo_library_outlined, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              "No projects posted yet.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              "Tap 'Add Post' to showcase your work!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}