// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lansio/View/Worker/Worker_EditProfile.dart';

// // --- Worker Profile Data Model ---
// class WorkerProfile {
//   final String name;
//   final String phoneNo;
//   final String aboutUs;
//   final double rating;
//   final List<String> postUrls;
//   final String? profileUrl;
//   final String? coverUrl;
//   final String? email;

//   const WorkerProfile({
//     required this.name,
//     required this.phoneNo,
//     required this.aboutUs,
//     required this.rating,
//     required this.postUrls,
//     this.profileUrl,
//     this.coverUrl,
//     this.email,
//   });

//   // Factory constructor to create from Firestore data
//   factory WorkerProfile.fromFirestore(Map<String, dynamic> data) {
//     return WorkerProfile(
//       name: data['name'] ?? 'Worker Name Not Set',
//       phoneNo: data['phoneNo'] ?? 'Phone not set',
//       aboutUs:
//           data['aboutUs'] ??
//           'No bio available. Please edit your profile to add one.',
//       rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
//       postUrls: List<String>.from(data['postUrls'] ?? []),
//       profileUrl: data['profileUrl'],
//       coverUrl: data['coverUrl'],
//       email: data['email'],
//     );
//   }

//   // Helper method for creating an editable copy
//   WorkerProfile copyWith({
//     String? name,
//     String? phoneNo,
//     String? aboutUs,
//     double? rating,
//     List<String>? postUrls,
//     String? profileUrl,
//     String? coverUrl,
//     String? email,
//   }) {
//     return WorkerProfile(
//       name: name ?? this.name,
//       phoneNo: phoneNo ?? this.phoneNo,
//       aboutUs: aboutUs ?? this.aboutUs,
//       rating: rating ?? this.rating,
//       postUrls: postUrls ?? this.postUrls,
//       profileUrl: profileUrl ?? this.profileUrl,
//       coverUrl: coverUrl ?? this.coverUrl,
//       email: email ?? this.email,
//     );
//   }
// }

// // --- The Main Worker Profile Screen Widget ---
// class WorkerProfilePage extends StatefulWidget {
//   const WorkerProfilePage({super.key});

//   @override
//   State<WorkerProfilePage> createState() => _WorkerProfilePageState();
// }

// class _WorkerProfilePageState extends State<WorkerProfilePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   WorkerProfile get _emptyWorkerProfile => WorkerProfile(
//     name: '',
//     phoneNo: '',
//     aboutUs: '',
//     rating: 4.5,
//     postUrls: [],
//     profileUrl: null,
//     coverUrl: null,
//     email: null,
//   );

//   // Real-time stream for worker data (Reads from 'workers' collection)
//   Stream<WorkerProfile?> get workerDataStream {
//     final userId = _auth.currentUser?.uid;
//     if (userId == null) return Stream.value(null);

//     return _firestore.collection('workers').doc(userId).snapshots().map((
//       snapshot,
//     ) {
//       if (snapshot.exists && snapshot.data() != null) {
//         return WorkerProfile.fromFirestore(snapshot.data()!);
//       }
//       return null;
//     });
//   }

//   void _handleAddPost() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Add Post functionality will be implemented'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userId = _auth.currentUser?.uid;

//     if (userId == null) {
//       return _buildLoginPrompt();
//     }

//     return Scaffold(
//       backgroundColor: const Color(0xFFECF2EC),
//       body: StreamBuilder<WorkerProfile?>(
//         stream: workerDataStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
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
//           const Text("Please login to view worker profile"),
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
//           const Text("No worker profile data found"),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => EditWorkerProfile(
//                     currentProfile: _emptyWorkerProfile,
//                     onProfileUpdated: (updatedProfile) {
//                       setState(() {});
//                     },
//                   ),
//                 ),
//               );
//             },
//             child: const Text("Create Profile"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileWithData(WorkerProfile profileData) {
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

//   Widget _buildProfileHeader(BuildContext context, WorkerProfile profileData) {
//     const double coverHeight = 180.0;
//     const double profilePictureRadius = 50.0;
//     const double stackHeight = coverHeight + profilePictureRadius;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: stackHeight,
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               // Cover Image - Using dynamic coverUrl from Firestore
//               Container(
//                 height: coverHeight,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                   image: DecorationImage(
//                     image: _getCoverImage(profileData.coverUrl),
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
//                           backgroundImage: _getProfileImage(
//                             profileData.profileUrl,
//                           ),
//                         ),
//                       ),

//                       // Edit Icon Button
//                       Positioned(
//                         right: 0,
//                         bottom: 0,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 // NEW (correct) - Use this:
//                                 builder: (context) => EditWorkerProfile(
//                                   currentProfile:
//                                       profileData, // ✅ Correct parameter
//                                   onProfileUpdated: (updatedProfile) {
//                                     setState(() {});
//                                   },
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
//                                 color: Theme.of(
//                                   context,
//                                 ).scaffoldBackgroundColor,
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
//           profileData.name,
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
//               profileData.phoneNo,
//               style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
//             ),
//             const SizedBox(width: 16),
//             const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
//             const SizedBox(width: 4),
//             Text(
//               '${profileData.rating.toStringAsFixed(1)} Rating',
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
//     if (imageUrl != null && imageUrl.isNotEmpty) {
//       return NetworkImage(imageUrl);
//     } else {
//       return const NetworkImage(
//         "https://sm.ign.com/ign_pk/cover/a/avatar-gen/avatar-generations_rpge.jpg",
//       );
//     }
//   }

//   ImageProvider _getCoverImage(String? imageUrl) {
//     if (imageUrl != null && imageUrl.isNotEmpty) {
//       return NetworkImage(imageUrl);
//     } else {
//       return const NetworkImage(
//         "https://placehold.co/600x400/007AFF/ffffff?text=Worker+Cover",
//       );
//     }
//   }

//   Widget _buildAboutUsSection(WorkerProfile profileData) {
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
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               profileData.aboutUs,
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

//   Widget _buildContactInfoSection(WorkerProfile profileData) {
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
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               children: [
//                 if (profileData.email != null && profileData.email!.isNotEmpty)
//                   _buildContactRow(Icons.email, 'Email', profileData.email!),
//                 if (profileData.phoneNo.isNotEmpty)
//                   _buildContactRow(Icons.phone, 'Phone', profileData.phoneNo),
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

//   Widget _buildPostsGrid(BuildContext context, WorkerProfile profileData) {
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
//         itemCount: profileData.postUrls.length,
//         itemBuilder: (context, index) {
//           final url = profileData.postUrls[index];
//           return AspectRatio(
//             aspectRatio: 1.0,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.grey.shade200,
//                 image: DecorationImage(
//                   image: NetworkImage(url),
//                   fit: BoxFit.cover,
//                 ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lansio/View/Contractor/fullScreenPostViewer.dart';
import 'package:lansio/View/SnackbarScreen.dart';
import 'dart:io';

import 'package:lansio/View/Worker/Worker_EditProfile.dart';
// ADD THIS IMPORT

// --- Worker Profile Data Model ---
class WorkerProfile {
  final String name;
  final String phoneNo;
  final String aboutUs;
  final double rating;
  final List<String> postUrls;
  final String? profileUrl;
  final String? coverUrl;
  final String? email;

  const WorkerProfile({
    required this.name,
    required this.phoneNo,
    required this.aboutUs,
    required this.rating,
    required this.postUrls,
    this.profileUrl,
    this.coverUrl,
    this.email,
  });

  // Factory constructor to create from Firestore data
  factory WorkerProfile.fromFirestore(Map<String, dynamic> data) {
    return WorkerProfile(
      name: data['name'] ?? 'Worker Name Not Set',
      phoneNo: data['phoneNo'] ?? 'Phone not set',
      aboutUs:
          data['aboutUs'] ??
          'No bio available. Please edit your profile to add one.',
      rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
      postUrls: List<String>.from(data['postUrls'] ?? []),
      profileUrl: data['profileUrl'],
      coverUrl: data['coverUrl'],
      email: data['email'],
    );
  }

  // Helper method for creating an editable copy
  WorkerProfile copyWith({
    String? name,
    String? phoneNo,
    String? aboutUs,
    double? rating,
    List<String>? postUrls,
    String? profileUrl,
    String? coverUrl,
    String? email,
  }) {
    return WorkerProfile(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      aboutUs: aboutUs ?? this.aboutUs,
      rating: rating ?? this.rating,
      postUrls: postUrls ?? this.postUrls,
      profileUrl: profileUrl ?? this.profileUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      email: email ?? this.email,
    );
  }
}

// --- The Main Worker Profile Screen Widget ---
class WorkerProfilePage extends StatefulWidget {
  const WorkerProfilePage({super.key});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  WorkerProfile get _emptyWorkerProfile => WorkerProfile(
    name: '',
    phoneNo: '',
    aboutUs: '',
    rating: 4.5,
    postUrls: [],
    profileUrl: null,
    coverUrl: null,
    email: null,
  );

  // Real-time stream for worker data (Reads from 'workers' collection)
  Stream<WorkerProfile?> get workerDataStream {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value(null);

    return _firestore.collection('workers').doc(userId).snapshots().map((
      snapshot,
    ) {
      if (snapshot.exists && snapshot.data() != null) {
        return WorkerProfile.fromFirestore(snapshot.data()!);
      }
      return null;
    });
  }

  // UPDATED: Add Post functionality with image/video upload
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

    // Show a temporary indicator while processing
    final SnackBar processingSnackbar = const SnackBar(
      content: Text('Uploading post... Please wait.'),
      duration: Duration(seconds: 30),
      backgroundColor: Color.fromARGB(255, 241, 199, 134),
    );
    ScaffoldMessenger.of(context).showSnackBar(processingSnackbar);

    try {
      final file = File(pickedFile.path);

      // 2. Define Storage path and Upload
      final fileName = pickedFile.name;
      final ref = _firebaseStorage
          .ref()
          .child('worker_posts')
          .child(userId)
          .child(fileName + '_${DateTime.now().millisecondsSinceEpoch}');

      final UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // 3. Update Firestore with the new post URL
      await _firestore.collection('workers').doc(userId).update({
        'postUrls': FieldValue.arrayUnion([downloadUrl]),
      });

      // Hide processing and show success
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Snackbarscreen().showCustomSnackBar(
        context,
        "Post Uploaded Successfully",
        bgColor: Colors.green,
      );
    } catch (e) {
      // Hide processing and show error
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Snackbarscreen().showCustomSnackBar(
        context,
        "Failed to upload post: $e",
        bgColor: Colors.green,
      );
    }
  }

  // Use this function to refresh the screen after an update
  void _refreshProfile(WorkerProfile updatedProfile) {
    setState(() {
      // The stream will reload the latest data, so we just trigger a rebuild.
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      return _buildLoginPrompt();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFECF2EC),
      body: StreamBuilder<WorkerProfile?>(
        stream: workerDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_off, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          const Text("Please login to view worker profile"),
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
          const Text("No worker profile data found"),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditWorkerProfile(
                    currentProfile: _emptyWorkerProfile,
                    onProfileUpdated: (updatedProfile) {
                      setState(() {});
                    },
                  ),
                ),
              );
            },
            child: const Text("Create Profile"),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileWithData(WorkerProfile profileData) {
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
          if (profileData.postUrls.isNotEmpty)
            _buildPostsGrid(context, profileData)
          else
            _buildNoPostsPlaceholder(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, WorkerProfile profileData) {
    const double coverHeight = 180.0;
    const double profilePictureRadius = 50.0;
    const double stackHeight = coverHeight + profilePictureRadius;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: stackHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Cover Image - Using dynamic coverUrl from Firestore
              Container(
                height: coverHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: _getCoverImage(profileData.coverUrl),
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
                          backgroundImage: _getProfileImage(
                            profileData.profileUrl,
                          ),
                        ),
                      ),

                      // Edit Icon Button - UPDATED: Passes the refresh callback
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditWorkerProfile(
                                  currentProfile: profileData,
                                  onProfileUpdated:
                                      _refreshProfile, // Use the refresh function
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
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
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
          profileData.name,
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
              profileData.phoneNo,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              '${profileData.rating.toStringAsFixed(1)} Rating',
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
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return NetworkImage(imageUrl);
    } else {
      return const NetworkImage(
        "https://sm.ign.com/ign_pk/cover/a/avatar-gen/avatar-generations_rpge.jpg",
      );
    }
  }

  ImageProvider _getCoverImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return NetworkImage(imageUrl);
    } else {
      return const NetworkImage(
        "https://placehold.co/600x400/007AFF/ffffff?text=Worker+Cover",
      );
    }
  }

  Widget _buildAboutUsSection(WorkerProfile profileData) {
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              profileData.aboutUs,
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

  Widget _buildContactInfoSection(WorkerProfile profileData) {
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                if (profileData.email != null && profileData.email!.isNotEmpty)
                  _buildContactRow(Icons.email, 'Email', profileData.email!),
                if (profileData.phoneNo.isNotEmpty)
                  _buildContactRow(Icons.phone, 'Phone', profileData.phoneNo),
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

  // UPDATED: Connected to FullScreenPostViewer with GestureDetector
  Widget _buildPostsGrid(BuildContext context, WorkerProfile profileData) {
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
        itemCount: profileData.postUrls.length,
        itemBuilder: (context, index) {
          final url = profileData.postUrls[index];

          // Simple heuristic to show video icon if the index is odd
          // Replace with actual file type checking if available
          final isVideo = index % 2 == 1;

          return GestureDetector(
            onTap: () {
              // Navigate to the full screen viewer
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      FullScreenPostViewer(postUrl: url, isVideo: isVideo),
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
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 4),
                            ],
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
