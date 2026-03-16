import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lansio/View/LoginPage.dart';
import 'package:lansio/View/User/User_editprofile.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Real-time stream that checks all collections
  Stream<Map<String, dynamic>?> get userDataStream {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value(null);

    return _firestore.collection('users').doc(userId).snapshots().map((
      snapshot,
    ) {
      if (snapshot.exists) {
        return snapshot.data();
      }
      return null;
    });
  }

  void _handleAddPost() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add Post functionality will be implemented'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      return _buildLoginPrompt();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 234, 232),

      body: StreamBuilder<Map<String, dynamic>?>(
        stream: userDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return _buildNoData();
          }

          final userData = snapshot.data!;
          return _buildProfileWithData(userData);
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

  // Logout function
  void _logout() async {
    try {
      await _auth.signOut();
      // Navigate to login page and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Loginpage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Show logout confirmation dialog
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_off, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          const Text("Please login to view profile"),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Loginpage()),
                (route) => false,
              );
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
          const Text("No profile data found"),
        ],
      ),
    );
  }

  Widget _buildProfileWithData(Map<String, dynamic> userData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildProfileHeader(context, userData),
          const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
          _buildAboutUsSection(userData),
          const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
          _buildContactInfoSection(userData),
          const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Saved Posts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    Map<String, dynamic> userData,
  ) {
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
              // Cover Image
              Container(
                height: coverHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: _getCoverImage(userData['coverImage']),
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

              // Profile Picture
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
                            userData['profileImage'],
                          ),
                        ),
                      ),

                      // Edit Icon Button (Optional - you can remove if not needed)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          // In your User Profile Page, add this to the edit button:
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditUserProfile(
                                  currentProfile: userData,
                                  onProfileUpdated: (updatedProfile) {
                                    setState(() {});
                                  },
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
          userData['name'] ?? 'User Name Not Set',
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
              userData['mobile'] ?? 'Phone not set',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.person, color: Colors.blue, size: 20),
            const SizedBox(width: 4),
            Text(
              userData['accountType'] ?? 'User',
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
      return const AssetImage("assets/userprofile.jpeg");
    }
  }

  ImageProvider _getCoverImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return NetworkImage(imageUrl);
    } else {
      return const NetworkImage(
        "https://placehold.co/600x400/007AFF/ffffff?text=User+Cover",
      );
    }
  }

  Widget _buildAboutUsSection(Map<String, dynamic> userData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Me',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 249, 251, 252),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              userData['bio'] ??
                  'No bio available. Share something about yourself!',
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

  Widget _buildContactInfoSection(Map<String, dynamic> userData) {
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
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                if (userData['email'] != null && userData['email']!.isNotEmpty)
                  _buildContactRow(Icons.email, 'Email', userData['email']!),
                if (userData['mobile'] != null &&
                    userData['mobile']!.isNotEmpty)
                  _buildContactRow(Icons.phone, 'Phone', userData['mobile']!),
                if (userData['address'] != null &&
                    userData['address']!.isNotEmpty)
                  _buildContactRow(
                    Icons.location_on,
                    'Address',
                    userData['address']!,
                  ),
                if (userData['dob'] != null)
                  _buildContactRow(
                    Icons.cake,
                    'Date of Birth',
                    _formatDate(userData['dob']),
                  ),
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

  String _formatDate(dynamic date) {
    if (date == null) return 'Not set';
    if (date is Timestamp) {
      return "${date.toDate().day}/${date.toDate().month}/${date.toDate().year}";
    }
    if (date is String) return date;
    return 'Not set';
  }
}
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lansio/View/LoginPage.dart';

// class UserProfilePage extends StatefulWidget {
//   const UserProfilePage({super.key});

//   @override
//   State<UserProfilePage> createState() => _UserProfilePageState();
// }

// class _UserProfilePageState extends State<UserProfilePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Real-time stream that checks all collections
//   Stream<Map<String, dynamic>?> get userDataStream {
//     final userId = _auth.currentUser?.uid;
//     if (userId == null) return Stream.value(null);

//     return _firestore.collection('users').doc(userId).snapshots().map((
//       snapshot,
//     ) {
//       if (snapshot.exists) {
//         return snapshot.data();
//       }
//       return null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userId = _auth.currentUser?.uid;

//     if (userId == null) {
//       return _buildLoginPrompt();
//     }

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F5F7),
//       body: StreamBuilder<Map<String, dynamic>?>(
//         stream: userDataStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data == null) {
//             return _buildNoData();
//           }

//           final userData = snapshot.data!;
//           return _buildProfile(userData);
//         },
//       ),
//     );
//   }

//   Widget _buildLoginPrompt() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.person_off, size: 60, color: Colors.grey),
//           const SizedBox(height: 16),
//           const Text("Please login to view profile"),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => Loginpage()),
//                 (route) => false,
//               );
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
//           const Text("No profile data found"),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfile(Map<String, dynamic> userData) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // Profile Header
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Container(
//               height: 160,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/coverimage.jpg"), // CORRECT
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     //bottom: -50,
//                     left: 0,
//                     right: 0,
//                     child: Center(
//                       child: CircleAvatar(
//                         radius: 80,
//                         backgroundColor: const Color.fromARGB(
//                           255,
//                           243,
//                           242,
//                           242,
//                         ),
//                         child: CircleAvatar(
//                           radius: 75,
//                           backgroundImage: _getImage(userData['profileImage']),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // User Info
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       userData['name'] ?? 'No Name',
//                       style: const TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       userData['accountType'] ?? 'User Account',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.green.shade700,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     _buildDetailRow(
//                       Icons.email,
//                       'Email',
//                       userData['email'] ?? 'Not set',
//                     ),
//                     _buildDetailRow(
//                       Icons.phone,
//                       'Mobile',
//                       userData['mobile'] ?? 'Not set',
//                     ),
//                     _buildDetailRow(
//                       Icons.location_on,
//                       'Address',
//                       userData['address'] ?? 'Not set',
//                     ),
//                     _buildDetailRow(
//                       Icons.cake,
//                       'Date of Birth',
//                       _formatDate(userData['dob']),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   ImageProvider _getImage(String? profileImage) {
//     if (profileImage != null &&
//         profileImage.isNotEmpty &&
//         profileImage.startsWith('http')) {
//       return NetworkImage(profileImage);
//     } else {
//       return const AssetImage("assets/userprofile.jpeg");
//     }
//   }

//   Widget _buildDetailRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(icon, color: const Color.fromARGB(255, 173, 138, 138)),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: const TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDate(dynamic date) {
//     if (date == null) return 'Not set';
//     if (date is Timestamp) {
//       return "${date.toDate().day}/${date.toDate().month}/${date.toDate().year}";
//     }
//     if (date is String) return date;
//     return 'Not set';
//   }
// }
