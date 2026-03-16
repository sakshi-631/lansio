

// // import 'dart:async';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:async/async.dart';
// // import 'package:lansio/View/common_chat_page.dart';
// // import 'package:lansio/screens/gemini_ai_page.dart';
// // import 'package:lansio/services/chat_service.dart';
// // import 'package:lansio/View/User/User_Message_Page.dart';

// // class Explorepage extends StatefulWidget {
// //   final int initialTabIndex;

// //   const Explorepage({super.key, this.initialTabIndex = 0});

// //   @override
// //   State<Explorepage> createState() => _ExplorepageState();
// // }

// // class _ExplorepageState extends State<Explorepage>
// //     with SingleTickerProviderStateMixin {
// //   late TabController _tabController;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final TextEditingController _searchController = TextEditingController();
// //   String _searchQuery = '';

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 4, vsync: this);
// //     _tabController.index = widget.initialTabIndex;
// //   }

// //   Stream<List<QuerySnapshot>> _searchAll(String query) {
// //     if (query.isEmpty) return Stream.value([]);

// //     final contractorsStream = _firestore
// //         .collection('contractors')
// //         .where('name', isGreaterThanOrEqualTo: query)
// //         .where('name', isLessThan: query + 'z')
// //         .snapshots();

// //     final workersStream = _firestore
// //         .collection('workers')
// //         .where('name', isGreaterThanOrEqualTo: query)
// //         .where('name', isLessThan: query + 'z')
// //         .snapshots();

// //     return StreamZip([contractorsStream, workersStream]);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF0F6F3),
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             // 🌿 Search Bar
// //             Padding(
// //               padding: const EdgeInsets.all(12.0),
// //               child: TextField(
// //                 controller: _searchController,
// //                 decoration: InputDecoration(
// //                   hintText: 'Search for contractors or workers...',
// //                   prefixIcon: Icon(Icons.search, color: Colors.green.shade800),
// //                   filled: true,
// //                   fillColor: Colors.green.shade50,
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(20),
// //                     borderSide: BorderSide.none,
// //                   ),
// //                   suffixIcon: _searchController.text.isNotEmpty
// //                       ? IconButton(
// //                           icon: const Icon(Icons.clear),
// //                           onPressed: () {
// //                             _searchController.clear();
// //                             setState(() {
// //                               _searchQuery = '';
// //                             });
// //                           },
// //                         )
// //                       : null,
// //                 ),
// //                 onChanged: (value) {
// //                   setState(() {
// //                     _searchQuery = value.trim();
// //                   });
// //                 },
// //               ),
// //             ),

// //             // 🧭 Tabs
// //             TabBar(
// //               controller: _tabController,
// //               labelColor: Colors.green.shade800,
// //               unselectedLabelColor: Colors.grey,
// //               indicatorColor: Colors.green.shade700,
// //               tabs: const [
// //                 Tab(text: "Contractors"),
// //                 Tab(text: "Workers"),
// //                 Tab(text: "Requests"),
// //                 Tab(text: "Designs"),
// //               ],
// //             ),

// //             // 🧱 Tab Views
// //             Expanded(
// //               child: TabBarView(
// //                 controller: _tabController,
// //                 children: [
// //                   _searchQuery.isNotEmpty
// //                       ? _buildSearchResults('contractors')
// //                       : _buildProfilesList('contractors'),
// //                   _searchQuery.isNotEmpty
// //                       ? _buildSearchResults('workers')
// //                       : _buildProfilesList('workers'),
// //                   _buildRequestsList(),
// //                   ChatBotPage(),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // 🔍 Search Results
// //   Widget _buildSearchResults(String collectionName) {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: _firestore
// //           .collection(collectionName)
// //           .where('name', isGreaterThanOrEqualTo: _searchQuery)
// //           .where('name', isLessThan: _searchQuery + 'z')
// //           .snapshots(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(
// //               child: CircularProgressIndicator(color: Colors.green));
// //         }
// //         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //           return const Center(child: Text("No matching profiles found"));
// //         }

// //         final results = snapshot.data!.docs;
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(12),
// //           itemCount: results.length,
// //           itemBuilder: (context, index) {
// //             final profile = results[index].data() as Map<String, dynamic>;
// //             return _buildProfileCard(
// //               collectionName: collectionName,
// //               userId: profile['userId'] ?? results[index].id,
// //               name: profile['name'] ?? 'Unnamed',
// //               email: profile['email'] ?? '',
// //               rating: profile['rating']?.toString() ?? '4.5',
// //               description:
// //                   profile['aboutUs'] ?? profile['bio'] ?? 'No details available',
// //               imageUrl:
// //                   profile['profileImage'] ?? profile['profileUrl'] ?? '',
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }

// //   // 👥 Profiles List
// //   Widget _buildProfilesList(String collectionName) {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: _firestore.collection(collectionName).snapshots(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(
// //               child: CircularProgressIndicator(color: Colors.green));
// //         }
// //         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //           return const Center(child: Text("No profiles found"));
// //         }

// //         final profiles = snapshot.data!.docs;
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(12),
// //           itemCount: profiles.length,
// //           itemBuilder: (context, index) {
// //             final profile = profiles[index].data() as Map<String, dynamic>;
// //             return _buildProfileCard(
// //               collectionName: collectionName,
// //               userId: profile['userId'] ?? profiles[index].id,
// //               name: profile['name'] ?? 'Unnamed',
// //               email: profile['email'] ?? '',
// //               rating: profile['rating']?.toString() ?? '4.5',
// //               description:
// //                   profile['aboutUs'] ?? profile['bio'] ?? 'No details available',
// //               imageUrl:
// //                   profile['profileImage'] ?? profile['profileUrl'] ?? '',
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }

// //   // 💳 Profile Card (with fixed Chat navigation)
// //   Widget _buildProfileCard({
// //     required String collectionName,
// //     required String userId,
// //     required String name,
// //     required String email,
// //     required String rating,
// //     required String description,
// //     required String imageUrl,
// //   }) {
// //     return Container(
// //       margin: const EdgeInsets.symmetric(vertical: 8),
// //       padding: const EdgeInsets.all(12),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.08),
// //             blurRadius: 8,
// //             offset: const Offset(0, 3),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Profile Info
// //           Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               ClipRRect(
// //                 borderRadius: BorderRadius.circular(12),
// //                 child: Image(
// //                   image: _getImage(imageUrl),
// //                   width: 70,
// //                   height: 70,
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(name,
// //                         style: const TextStyle(
// //                             fontWeight: FontWeight.bold, fontSize: 16)),
// //                     const SizedBox(height: 4),
// //                     Text(email,
// //                         style: const TextStyle(color: Colors.grey, fontSize: 13)),
// //                     const SizedBox(height: 6),
// //                     Text(description,
// //                         maxLines: 2,
// //                         overflow: TextOverflow.ellipsis,
// //                         style: const TextStyle(color: Colors.black54)),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 10),

// //           // Buttons Row
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               // 💬 Message Button (Updated)
// //               SizedBox(
// //                 height: 34,
// //                 child: ElevatedButton.icon(
// //                  onPressed: () async {
// //   final currentUser = FirebaseAuth.instance.currentUser!;
// //   final chatService = ChatService();

// //   try {
// //     final chatId = await chatService.getOrCreateChatId(
// //       senderId: currentUser.uid,
// //       senderType: 'user',
// //       receiverId: userId,
// //       receiverType:
// //           collectionName == 'contractors' ? 'contractor' : 'worker',
// //     );

// //     // ✅ Navigate safely after chat is ready
// //     if (context.mounted) {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (_) => CommonChatPage(
// //             chatId: chatId,
// //             receiverId: userId,
// //             receiverName: name,
// //             receiverType: collectionName == 'contractors'
// //                 ? 'contractor'
// //                 : 'worker',
// //             senderId: currentUser.uid,
// //             senderType: 'user',
// //           ),
// //         ),
// //       );
// //     }
// //   } catch (e) {
// //     debugPrint("❌ Error navigating to ChatPage: $e");
// //     if (context.mounted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Failed to open chat: $e")),
// //       );
// //     }
// //   }
// // },

// //                   icon: const Icon(Icons.message, size: 16, color: Colors.white),
// //                   label:
// //                       const Text("Message", style: TextStyle(fontSize: 13)),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.green.shade700,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               // 📩 Request
// //               SizedBox(
// //                 height: 34,
// //                 child: ElevatedButton.icon(
// //                   onPressed: () {},
// //                   icon: const Icon(Icons.send, size: 16, color: Colors.white),
// //                   label: const Text("Request", style: TextStyle(fontSize: 13)),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.orange.shade700,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               // ⭐ Rating
// //               Row(
// //                 children: [
// //                   const Icon(Icons.star, color: Colors.amber, size: 18),
// //                   Text(rating,
// //                       style: const TextStyle(
// //                           color: Colors.black87,
// //                           fontWeight: FontWeight.bold)),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   ImageProvider _getImage(String? imageUrl) {
// //     if (imageUrl != null && imageUrl.isNotEmpty) {
// //       return imageUrl.startsWith('http')
// //           ? NetworkImage(imageUrl)
// //           : AssetImage(imageUrl) as ImageProvider;
// //     }
// //     return const AssetImage("assets/userprofile.jpeg");
// //   }

// //   // 🧩 Placeholder for Requests
// //   Widget _buildRequestsList() {
// //     return const Center(
// //         child: Text("Requests feature coming soon...",
// //             style: TextStyle(color: Colors.grey)));
// //   }
// // }















// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:async/async.dart';
// import 'package:lansio/View/common_chat_page.dart';
// import 'package:lansio/screens/gemini_ai_page.dart';
// import 'package:lansio/services/chat_service.dart';
// import 'package:lansio/View/User/User_Message_Page.dart';

// class Explorepage extends StatefulWidget {
//   final int initialTabIndex;

//   const Explorepage({super.key, this.initialTabIndex = 0});

//   @override
//   State<Explorepage> createState() => _ExplorepageState();
// }

// class _ExplorepageState extends State<Explorepage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//     _tabController.index = widget.initialTabIndex;
//   }

//   Stream<List<QuerySnapshot>> _searchAll(String query) {
//     if (query.isEmpty) return Stream.value([]);

//     final contractorsStream = _firestore
//         .collection('contractors')
//         .where('name', isGreaterThanOrEqualTo: query)
//         .where('name', isLessThan: query + 'z')
//         .snapshots();

//     final workersStream = _firestore
//         .collection('workers')
//         .where('name', isGreaterThanOrEqualTo: query)
//         .where('name', isLessThan: query + 'z')
//         .snapshots();

//     return StreamZip([contractorsStream, workersStream]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF0F6F3),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // 🌿 Search Bar
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search for contractors or workers...',
//                   prefixIcon: Icon(Icons.search, color: Colors.green.shade800),
//                   filled: true,
//                   fillColor: Colors.green.shade50,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide.none,
//                   ),
//                   suffixIcon: _searchController.text.isNotEmpty
//                       ? IconButton(
//                           icon: const Icon(Icons.clear),
//                           onPressed: () {
//                             _searchController.clear();
//                             setState(() {
//                               _searchQuery = '';
//                             });
//                           },
//                         )
//                       : null,
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _searchQuery = value.trim();
//                   });
//                 },
//               ),
//             ),

//             // 🧭 Tabs
//             TabBar(
//               controller: _tabController,
//               labelColor: Colors.green.shade800,
//               unselectedLabelColor: Colors.grey,
//               indicatorColor: Colors.green.shade700,
//               tabs: const [
//                 Tab(text: "Contractors"),
//                 Tab(text: "Workers"),
//                 Tab(text: "Requests"),
//                 Tab(text: "Designs"),
//               ],
//             ),

//             // 🧱 Tab Views
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _searchQuery.isNotEmpty
//                       ? _buildSearchResults('contractors')
//                       : _buildProfilesList('contractors'),
//                   _searchQuery.isNotEmpty
//                       ? _buildSearchResults('workers')
//                       : _buildProfilesList('workers'),
//                   _buildRequestsList(),
//                   ChatBotPage(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔍 Search Results
//   Widget _buildSearchResults(String collectionName) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection(collectionName)
//           .where('name', isGreaterThanOrEqualTo: _searchQuery)
//           .where('name', isLessThan: _searchQuery + 'z')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//               child: CircularProgressIndicator(color: Colors.green));
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text("No matching profiles found"));
//         }

//         final results = snapshot.data!.docs;
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: results.length,
//           itemBuilder: (context, index) {
//             final profile = results[index].data() as Map<String, dynamic>;
//             return _buildProfileCard(
//               collectionName: collectionName,
//               userId: profile['userId'] ?? results[index].id,
//               name: profile['name'] ?? 'Unnamed',
//               email: profile['email'] ?? '',
//               rating: profile['rating']?.toString() ?? '4.5',
//               description:
//                   profile['aboutUs'] ?? profile['bio'] ?? 'No details available',
//               imageUrl:
//                   profile['profileImage'] ?? profile['profileUrl'] ?? '',
//             );
//           },
//         );
//       },
//     );
//   }

//   // 👥 Profiles List
//   Widget _buildProfilesList(String collectionName) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection(collectionName).snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//               child: CircularProgressIndicator(color: Colors.green));
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text("No profiles found"));
//         }

//         final profiles = snapshot.data!.docs;
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: profiles.length,
//           itemBuilder: (context, index) {
//             final profile = profiles[index].data() as Map<String, dynamic>;
//             return _buildProfileCard(
//               collectionName: collectionName,
//               userId: profile['userId'] ?? profiles[index].id,
//               name: profile['name'] ?? 'Unnamed',
//               email: profile['email'] ?? '',
//               rating: profile['rating']?.toString() ?? '4.5',
//               description:
//                   profile['aboutUs'] ?? profile['bio'] ?? 'No details available',
//               imageUrl:
//                   profile['profileImage'] ?? profile['profileUrl'] ?? '',
//             );
//           },
//         );
//       },
//     );
//   }

//   // 💳 Profile Card (with fixed Chat navigation)
//   Widget _buildProfileCard({
//     required String collectionName,
//     required String userId,
//     required String name,
//     required String email,
//     required String rating,
//     required String description,
//     required String imageUrl,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Profile Info
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image(
//                   image: _getImage(imageUrl),
//                   width: 70,
//                   height: 70,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(name,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                     const SizedBox(height: 4),
//                     Text(email,
//                         style: const TextStyle(color: Colors.grey, fontSize: 13)),
//                     const SizedBox(height: 6),
//                     Text(description,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(color: Colors.black54)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),

//           // Buttons Row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // 💬 Message Button (Updated)
//               SizedBox(
//                 height: 34,
//                 child: ElevatedButton.icon(
//                  onPressed: () async {
//   final currentUser = FirebaseAuth.instance.currentUser!;
//   final chatService = ChatService();

//   try {
//     final chatId = await chatService.getOrCreateChatId(
//       senderId: currentUser.uid,
//       senderType: 'user',
//       receiverId: userId,
//       receiverType:
//           collectionName == 'contractors' ? 'contractor' : 'worker',
//     );

//     // ✅ Navigate safely after chat is ready
//     if (context.mounted) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => CommonChatPage(
//             chatId: chatId,
//             receiverId: userId,
//             receiverName: name,
//             receiverType: collectionName == 'contractors'
//                 ? 'contractor'
//                 : 'worker',
//             senderId: currentUser.uid,
//             senderType: 'user',
//           ),
//         ),
//       );
//     }
//   } catch (e) {
//     debugPrint("❌ Error navigating to ChatPage: $e");
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to open chat: $e")),
//       );
//     }
//   }
// },

//                   icon: const Icon(Icons.message, size: 16, color: Colors.white),
//                   label:
//                       const Text("Message", style: TextStyle(fontSize: 13)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade700,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ),

//               // 📩 Request
//               SizedBox(
//                 height: 34,
//                 child: ElevatedButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.send, size: 16, color: Colors.white),
//                   label: const Text("Request", style: TextStyle(fontSize: 13)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange.shade700,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ),

//               // ⭐ Rating
//               Row(
//                 children: [
//                   const Icon(Icons.star, color: Colors.amber, size: 18),
//                   Text(rating,
//                       style: const TextStyle(
//                           color: Colors.black87,
//                           fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   ImageProvider _getImage(String? imageUrl) {
//     if (imageUrl != null && imageUrl.isNotEmpty) {
//       return imageUrl.startsWith('http')
//           ? NetworkImage(imageUrl)
//           : AssetImage(imageUrl) as ImageProvider;
//     }
//     return const AssetImage("assets/userprofile.jpeg");
//   }

//   // 🧩 Placeholder for Requests
//   Widget _buildRequestsList() {
//     return const Center(
//         child: Text("Requests feature coming soon...",
//             style: TextStyle(color: Colors.grey)));
//   }
// }













import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import 'package:lansio/services/chat_service.dart';
import 'package:lansio/View/common_chat_page.dart';
import 'package:lansio/View/User/create_request_page.dart';
import 'package:lansio/services/gemini_service.dart';

class Explorepage extends StatefulWidget {
  final int initialTabIndex;

  const Explorepage({super.key, this.initialTabIndex = 0});

  @override
  State<Explorepage> createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = widget.initialTabIndex;
  }

  Stream<List<QuerySnapshot>> _searchAll(String query) {
    if (query.isEmpty) return Stream.value([]);

    final contractorsStream = _firestore
        .collection('contractors')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z')
        .snapshots();

    final workersStream = _firestore
        .collection('workers')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z')
        .snapshots();

    return StreamZip([contractorsStream, workersStream]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6F3),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for contractors or workers...',
                  prefixIcon: Icon(Icons.search, color: Colors.green.shade800),
                  filled: true,
                  fillColor: Colors.green.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() => _searchQuery = value.trim());
                },
              ),
            ),

            // Tabs
            TabBar(
              controller: _tabController,
              labelColor: Colors.green.shade800,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.green.shade700,
              tabs: const [
                Tab(text: "Contractors"),
                Tab(text: "Workers"),
                Tab(text: "Requests"),
                Tab(text: "Designs"),
              ],
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _searchQuery.isNotEmpty
                      ? _buildSearchResults('contractors')
                      : _buildProfilesList('contractors'),
                  _searchQuery.isNotEmpty
                      ? _buildSearchResults('workers')
                      : _buildProfilesList('workers'),
                  _buildRequestsList(),
                  _buildDesignChatbot(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilesList(String collectionName) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(collectionName).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.green));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No profiles found"));
        }

        final profiles = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            final profile = profiles[index].data() as Map<String, dynamic>;
            final profileId = profiles[index].id;

            return _buildProfileCard(
              collectionName: collectionName,
              profileId: profileId,
              name: profile['name'] ?? 'Unnamed',
              email: profile['email'] ?? '',
              rating: profile['rating']?.toString() ?? '4.5',
              description:
                  profile['aboutUs'] ?? profile['bio'] ?? 'No details available',
              imageUrl:
                  profile['profileImage'] ?? profile['profileUrl'] ?? '',
            );
          },
        );
      },
    );
  }

  Widget _buildSearchResults(String collectionName) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection(collectionName)
          .where('name', isGreaterThanOrEqualTo: _searchQuery)
          .where('name', isLessThan: _searchQuery + 'z')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        }
        final results = snapshot.data!.docs;
        if (results.isEmpty) return const Center(child: Text("No matching profiles found"));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final profile = results[index].data() as Map<String, dynamic>;
            final profileId = results[index].id;

            return _buildProfileCard(
              collectionName: collectionName,
              profileId: profileId,
              name: profile['name'] ?? 'Unnamed',
              email: profile['email'] ?? '',
              rating: profile['rating']?.toString() ?? '4.5',
              description:
                  profile['aboutUs'] ?? profile['bio'] ?? 'No details available',
              imageUrl:
                  profile['profileImage'] ?? profile['profileUrl'] ?? '',
            );
          },
        );
      },
    );
  }

  Widget _buildProfileCard({
    required String collectionName,
    required String profileId,
    required String name,
    required String email,
    required String rating,
    required String description,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: _getImage(imageUrl),
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(email,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 6),
                    Text(description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Message Button
              SizedBox(
                height: 34,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final currentUser = FirebaseAuth.instance.currentUser!;
                    final chatService = ChatService();

                    try {
                      final chatId = await chatService.getOrCreateChatId(
                        senderId: currentUser.uid,
                        senderType: 'user',
                        receiverId: profileId,
                        receiverType:
                            collectionName == 'contractors' ? 'contractor' : 'worker',
                      );

                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CommonChatPage(
                              chatId: chatId,
                              receiverId: profileId,
                              receiverName: name,
                              receiverType:
                                  collectionName == 'contractors'
                                      ? 'contractor'
                                      : 'worker',
                              senderId: currentUser.uid,
                              senderType: 'user',
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      debugPrint("❌ Error navigating to ChatPage: $e");
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to open chat: $e")),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.message, size: 16, color: Colors.white),
                  label: const Text("Message", style: TextStyle(fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              // Request Button
              SizedBox(
                height: 34,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => UserProjectRequestPage(
                          contractorId: profileId,
                          contractorCollection: collectionName,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send, size: 16, color: Colors.white),
                  label: const Text("Request", style: TextStyle(fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              // Rating
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  Text(rating,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ImageProvider _getImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      if (imageUrl.startsWith('http')) return NetworkImage(imageUrl);
      if (imageUrl.startsWith('assets/')) return AssetImage(imageUrl);
    }
    return const AssetImage("assets/userprofile.jpeg");
  }

  // Requests Tab
  Widget _buildRequestsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('requests').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final requests = snapshot.data!.docs;
        if (requests.isEmpty) {
          return const Center(child: Text("No requests available"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final req = requests[index].data() as Map<String, dynamic>;
            final name = req['name'] ?? 'Unknown';
            final type = req['type'] ?? 'General';
            final status = req['status'] ?? 'Pending';
            final image = req['image'] ?? '';

            Color statusColor;
            if (status == "Pending") {
              statusColor = Colors.orange;
            } else if (status == "Accepted") {
              statusColor = Colors.green;
            } else {
              statusColor = Colors.red;
            }

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(image)),
                title: Text(name),
                subtitle: Text(type),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(status, style: const TextStyle(color: Colors.white)),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Designs Tab (AI Chatbot)
  Widget _buildDesignChatbot(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final GeminiService _geminiService = GeminiService();
    final List<Map<String, String>> _messages = [];
    bool _isLoading = false;

    return StatefulBuilder(
      builder: (context, setState) {
        Future<void> _sendText() async {
          final userMessage = _controller.text.trim();
          if (userMessage.isEmpty) return;

          setState(() {
            _messages.add({"role": "user", "text": userMessage});
            _isLoading = true;
            _controller.clear();
          });

          final reply = await _geminiService.generateText(userMessage);

          setState(() {
            _messages.add({"role": "bot", "text": reply});
            _isLoading = false;
          });
        }

        return Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Text("AI Design Assistant 🤖",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple)),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final isUser = msg["role"] == "user";

                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.deepPurpleAccent : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          msg["text"] ?? "",
                          style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Ask AI your decoration or design idea...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.deepPurple),
                    onPressed: _sendText,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
