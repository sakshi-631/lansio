// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lansio/View/User/ExplorePage.dart';
// import 'package:async/async.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Sample contractor posts (newest first)
//   final List<Map<String, dynamic>> contractorPosts = [
//     {
//       "name": "Arjun Patel",
//       "profile": "assets/profile.jpg",
//       "description": "Modern garden landscape design completed today 🌿✨",
//       "media": [
//         "assets/project.jpeg",
//         "assets/project.jpeg",
//         "assets/project.jpeg",
//       ],
//       "isSaved": false,
//     },
//     {
//       "name": "Riya Builders",
//       "profile": "assets/profile.jpg",
//       "description": "New villa construction started 🏠",
//       "media": ["assets/construction.jpg", "assets/construction.jpg"],
//       "isSaved": false,
//     },
//     {
//       "name": "GreenLand Landscaping",
//       "profile": "assets/profile.jpeg",
//       "description": "Vertical garden project completed successfully! 🌱💧",
//       "media": [
//         "assets/vertical.jpeg",
//         "assets/vertical.jpeg",
//         "assets/vertical.jpeg",
//         "assets/vertical.jpeg",
//       ],
//       "isSaved": false,
//     },
//   ];

//   // Search across all collections
//   Stream<List<QuerySnapshot>> _searchAll(String query) {
//     if (query.isEmpty) return Stream.value([]);

//     final usersStream = _firestore
//         .collection('users')
//         .where('name', isGreaterThanOrEqualTo: query)
//         .where('name', isLessThan: query + 'z')
//         .snapshots();

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

//     return StreamZip([usersStream, contractorsStream, workersStream]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFECF2EC),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Search Bar
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   hintText: "Search services, contractors, or workers...",
//                   prefixIcon: const Icon(Icons.search),
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
//                     _searchQuery = value;
//                   });
//                 },
//               ),
//             ),

//             // Show search results or normal homepage
//             Expanded(
//               child: _searchQuery.isNotEmpty
//                   ? _buildSearchResults()
//                   : _buildNormalHomepage(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchResults() {
//     return StreamBuilder<List<QuerySnapshot>>(
//       stream: _searchAll(_searchQuery),
//       builder: (context, snapshot) {
//         // Combine all results
//         List<QueryDocumentSnapshot> allResults = [];
//         if (snapshot.hasData) {
//           for (var querySnapshot in snapshot.data!) {
//             allResults.addAll(querySnapshot.docs);
//           }
//         }

//         // Show no results message
//         if (allResults.isEmpty) {
//           return const Center(child: Text('No results found'));
//         }

//         // Show results
//         return ListView.builder(
//           itemCount: allResults.length,
//           itemBuilder: (context, index) {
//             final doc = allResults[index];
//             final data = doc.data() as Map<String, dynamic>;
//             final collection = doc.reference.path.split('/')[0];

//             return _buildSearchResultCard(data, collection);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildSearchResultCard(Map<String, dynamic> data, String collection) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//       child: ListTile(
//         leading: CircleAvatar(backgroundImage: _getImage(data['profileImage'])),
//         title: Text(data['name'] ?? 'No Name'),
//         subtitle: Text(data['email'] ?? 'No Email'),
//         trailing: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: _getColor(collection),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             _getLabel(collection),
//             style: const TextStyle(color: Colors.white, fontSize: 12),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNormalHomepage() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Hero Image
//           Container(
//             height: 300,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/homepg.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Container(
//               alignment: Alignment.center,
//               color: Colors.black.withOpacity(0.3),
//               child: const Text(
//                 "Connect, Create,\nGrow your space",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 35,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Action Buttons
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildActionCard(
//                   Icons.nature,
//                   "Find\nContractors",
//                   const Color.fromARGB(255, 123, 214, 138),
//                   () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => Explorepage(initialTabIndex: 0),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildActionCard(
//                   Icons.construction,
//                   "Hire\nWorkers",
//                   const Color.fromARGB(255, 194, 155, 155),
//                   () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => Explorepage(initialTabIndex: 1),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildActionCard(
//                   Icons.post_add,
//                   "Create\nYour Design",
//                   const Color.fromARGB(255, 191, 201, 191),
//                   () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => Explorepage(initialTabIndex: 3),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Latest Posts Title
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Text(
//               "Contractor Posts",
//               style: TextStyle(
//                 color: Colors.green.shade800,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),

//           const SizedBox(height: 10),

//           // Contractor Feed
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: contractorPosts.length,
//             itemBuilder: (context, index) {
//               final post = contractorPosts[index];
//               return _buildPostCard(post, index);
//             },
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
//     }
//     return const AssetImage("assets/userprofile.jpeg");
//   }

//   Color _getColor(String collection) {
//     switch (collection) {
//       case 'users':
//         return Colors.green;
//       case 'contractors':
//         return Colors.orange;
//       case 'workers':
//         return Colors.blue;
//       default:
//         return Colors.grey;
//     }
//   }

//   String _getLabel(String collection) {
//     switch (collection) {
//       case 'users':
//         return 'User';
//       case 'contractors':
//         return 'Contractor';
//       case 'workers':
//         return 'Worker';
//       default:
//         return 'User';
//     }
//   }

//   // Action Card Widget
//   Widget _buildActionCard(
//     IconData icon,
//     String title,
//     Color color,
//     VoidCallback onTap,
//   ) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: 105,
//         height: 100,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 28, color: Colors.green.shade800),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Post Card Widget (With Save Icon)
//   Widget _buildPostCard(Map<String, dynamic> post, int index) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
//           // Contractor Info + Save Icon
//           ListTile(
//             leading: CircleAvatar(backgroundImage: AssetImage(post["profile"])),
//             title: Text(
//               post["name"],
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             trailing: IconButton(
//               icon: Icon(
//                 post["isSaved"]
//                     ? Icons.bookmark
//                     : Icons.bookmark_border_outlined,
//                 color: post["isSaved"] ? Colors.green : Colors.grey[700],
//               ),
//               onPressed: () {
//                 setState(() {
//                   post["isSaved"] = !post["isSaved"];
//                 });
//               },
//             ),
//           ),

//           // Scrollable Media
//           SizedBox(
//             height: 250,
//             child: PageView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: post["media"].length,
//               itemBuilder: (context, i) {
//                 final mediaPath = post["media"][i];
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.asset(
//                     mediaPath,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Description
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Text(
//               post["description"],
//               style: const TextStyle(fontSize: 15, color: Colors.black87),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

// ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lansio/View/User/ExplorePage.dart';
// import 'package:async/async.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Stream to get combined posts from contractors and workers
//   Stream<List<Map<String, dynamic>>> get combinedPostsStream {
//     final contractorsStream = _firestore
//         .collection('contractors')
//         .where('postUrls', isNotEqualTo: []) // Only users with posts
//         .snapshots();

//     final workersStream = _firestore
//         .collection('workers')
//         .where('postUrls', isNotEqualTo: []) // Only users with posts
//         .snapshots();

//     return StreamZip([contractorsStream, workersStream]).map((results) {
//       List<Map<String, dynamic>> allPosts = [];

//       // Process contractors posts
//       for (var contractorDoc in results[0].docs) {
//         final contractorData = contractorDoc.data();
//         final postUrls = List<String>.from(contractorData['postUrls'] ?? []);

//         for (var postUrl in postUrls) {
//           allPosts.add({
//             'userId': contractorDoc.id,
//             'userType': 'contractor',
//             'name': contractorData['name'] ?? 'Contractor',
//             'profileImage':
//                 contractorData['profileImage'] ?? contractorData['profileUrl'],
//             'postUrl': postUrl,
//             'description': contractorData['bio'] ?? 'No description',
//             'rating': contractorData['rating'] ?? 4.5,
//             'timestamp':
//                 contractorData['updatedAt'] ?? FieldValue.serverTimestamp(),
//           });
//         }
//       }

//       // Process workers posts
//       for (var workerDoc in results[1].docs) {
//         final workerData = workerDoc.data();
//         final postUrls = List<String>.from(workerData['postUrls'] ?? []);

//         for (var postUrl in postUrls) {
//           allPosts.add({
//             'userId': workerDoc.id,
//             'userType': 'worker',
//             'name': workerData['name'] ?? 'Worker',
//             'profileImage':
//                 workerData['profileImage'] ?? workerData['profileUrl'],
//             'postUrl': postUrl,
//             'description': workerData['aboutUs'] ?? 'No description',
//             'rating': workerData['rating'] ?? 4.5,
//             'timestamp':
//                 workerData['updatedAt'] ?? FieldValue.serverTimestamp(),
//           });
//         }
//       }

//       // Sort by timestamp (newest first)
//       allPosts.sort((a, b) {
//         final aTime = a['timestamp'] is Timestamp
//             ? a['timestamp'] as Timestamp
//             : Timestamp.now();
//         final bTime = b['timestamp'] is Timestamp
//             ? b['timestamp'] as Timestamp
//             : Timestamp.now();
//         return bTime.compareTo(aTime);
//       });

//       return allPosts;
//     });
//   }

//   // Search across all collections
//   Stream<List<QuerySnapshot>> _searchAll(String query) {
//     if (query.isEmpty) return Stream.value([]);

//     final usersStream = _firestore
//         .collection('users')
//         .where('name', isGreaterThanOrEqualTo: query)
//         .where('name', isLessThan: query + 'z')
//         .snapshots();

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

//     return StreamZip([usersStream, contractorsStream, workersStream]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFECF2EC),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Search Bar
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   hintText: "Search services, contractors, or workers...",
//                   prefixIcon: const Icon(Icons.search),
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
//                     _searchQuery = value;
//                   });
//                 },
//               ),
//             ),

//             // Show search results or normal homepage
//             Expanded(
//               child: _searchQuery.isNotEmpty
//                   ? _buildSearchResults()
//                   : _buildNormalHomepage(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchResults() {
//     return StreamBuilder<List<QuerySnapshot>>(
//       stream: _searchAll(_searchQuery),
//       builder: (context, snapshot) {
//         // Combine all results
//         List<QueryDocumentSnapshot> allResults = [];
//         if (snapshot.hasData) {
//           for (var querySnapshot in snapshot.data!) {
//             allResults.addAll(querySnapshot.docs);
//           }
//         }

//         // Show no results message
//         if (allResults.isEmpty) {
//           return const Center(child: Text('No results found'));
//         }

//         // Show results
//         return ListView.builder(
//           itemCount: allResults.length,
//           itemBuilder: (context, index) {
//             final doc = allResults[index];
//             final data = doc.data() as Map<String, dynamic>;
//             final collection = doc.reference.path.split('/')[0];

//             return _buildSearchResultCard(data, collection);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildSearchResultCard(Map<String, dynamic> data, String collection) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundImage: _getImage(
//             data['profileImage'] ?? data['profileUrl'],
//           ),
//         ),
//         title: Text(data['name'] ?? 'No Name'),
//         subtitle: Text(data['email'] ?? 'No Email'),
//         trailing: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: _getColor(collection),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             _getLabel(collection),
//             style: const TextStyle(color: Colors.white, fontSize: 12),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNormalHomepage() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Hero Image
//           Container(
//             height: 300,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/homepg.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Container(
//               alignment: Alignment.center,
//               color: Colors.black.withOpacity(0.3),
//               child: const Text(
//                 "Connect, Create,\nGrow your space",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 35,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Action Buttons
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildActionCard(
//                   Icons.nature,
//                   "Find\nContractors",
//                   const Color.fromARGB(255, 123, 214, 138),
//                   () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => Explorepage(initialTabIndex: 0),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildActionCard(
//                   Icons.construction,
//                   "Hire\nWorkers",
//                   const Color.fromARGB(255, 194, 155, 155),
//                   () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => Explorepage(initialTabIndex: 1),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildActionCard(
//                   Icons.post_add,
//                   "Create\nYour Design",
//                   const Color.fromARGB(255, 191, 201, 191),
//                   () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => Explorepage(initialTabIndex: 3),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Latest Posts Title
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Text(
//               "Latest Posts from Contractors & Workers",
//               style: TextStyle(
//                 color: Colors.green.shade800,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),

//           const SizedBox(height: 10),

//           // Real-time Posts Feed from Firestore
//           _buildRealTimePosts(),
//         ],
//       ),
//     );
//   }

//   Widget _buildRealTimePosts() {
//     return StreamBuilder<List<Map<String, dynamic>>>(
//       stream: combinedPostsStream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }

//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Center(
//               child: Text(
//                 'No posts yet.\nContractors and workers will appear here when they upload posts.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey, fontSize: 16),
//               ),
//             ),
//           );
//         }

//         final posts = snapshot.data!;

//         return ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
//             return _buildRealTimePostCard(post);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildRealTimePostCard(Map<String, dynamic> post) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
//           // User Info + User Type Badge
//           ListTile(
//             leading: CircleAvatar(
//               backgroundImage: _getImage(post['profileImage']),
//             ),
//             title: Text(
//               post['name'],
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             // subtitle: Text(
//             //   'User ID: ${post['userId']}',
//             //   style: const TextStyle(fontSize: 12, color: Colors.grey),
//             // ),
//             trailing: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: post['userType'] == 'contractor'
//                     ? Colors.orange
//                     : Colors.blue,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 post['userType'] == 'contractor' ? 'Contractor' : 'Worker',
//                 style: const TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//           ),

//           // Single Post Image/Video
//           Container(
//             height: 300,
//             margin: const EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.grey.shade200,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 post['postUrl'],
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Center(
//                     child: CircularProgressIndicator(
//                       value: loadingProgress.expectedTotalBytes != null
//                           ? loadingProgress.cumulativeBytesLoaded /
//                                 loadingProgress.expectedTotalBytes!
//                           : null,
//                     ),
//                   );
//                 },
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   color: Colors.grey.shade300,
//                   child: const Center(
//                     child: Icon(
//                       Icons.broken_image,
//                       color: Colors.grey,
//                       size: 50,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Description and Rating
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   post['description'],
//                   style: const TextStyle(fontSize: 15, color: Colors.black87),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     const Icon(Icons.star, color: Colors.amber, size: 16),
//                     const SizedBox(width: 4),
//                     Text(
//                       '${post['rating']?.toStringAsFixed(1) ?? '4.5'} Rating',
//                       style: const TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   ImageProvider _getImage(String? imageUrl) {
//     if (imageUrl != null && imageUrl.isNotEmpty) {
//       if (imageUrl.startsWith('http')) {
//         return NetworkImage(imageUrl);
//       } else if (imageUrl.startsWith('assets/')) {
//         return AssetImage(imageUrl);
//       }
//     }
//     return const AssetImage("assets/userprofile.jpeg");
//   }

//   Color _getColor(String collection) {
//     switch (collection) {
//       case 'users':
//         return Colors.green;
//       case 'contractors':
//         return Colors.orange;
//       case 'workers':
//         return Colors.blue;
//       default:
//         return Colors.grey;
//     }
//   }

//   String _getLabel(String collection) {
//     switch (collection) {
//       case 'users':
//         return 'User';
//       case 'contractors':
//         return 'Contractor';
//       case 'workers':
//         return 'Worker';
//       default:
//         return 'User';
//     }
//   }

//   // Action Card Widget
//   Widget _buildActionCard(
//     IconData icon,
//     String title,
//     Color color,
//     VoidCallback onTap,
//   ) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: 105,
//         height: 100,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 28, color: Colors.green.shade800),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lansio/View/User/ExplorePage.dart';
import 'package:async/async.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to get combined posts from contractors and workers with proper structure
  Stream<List<Map<String, dynamic>>> get combinedPostsStream {
    final contractorsStream = _firestore
        .collection('contractors')
        .where('posts', isNotEqualTo: []) // Look for posts array
        .snapshots();

    final workersStream = _firestore
        .collection('workers')
        .where('posts', isNotEqualTo: []) // Look for posts array
        .snapshots();

    return StreamZip([contractorsStream, workersStream]).map((results) {
      List<Map<String, dynamic>> allPosts = [];

      // Process contractors posts
      for (var contractorDoc in results[0].docs) {
        final contractorData = contractorDoc.data();
        final posts = List<Map<String, dynamic>>.from(
          contractorData['posts'] ?? [],
        );

        for (var post in posts) {
          allPosts.add({
            'userId': contractorDoc.id,
            'userType': 'contractor',
            'name': contractorData['name'] ?? 'Contractor',
            'profileImage':
                contractorData['profileImage'] ??
                contractorData['profileUrl'] ??
                '',
            'postUrl':
                post['url'] ??
                post['imageUrl'] ??
                '', // CORRECTED: Use 'url' field
            'description':
                post['description'] ??
                contractorData['bio'] ??
                'No description',
            'rating': contractorData['rating'] ?? 4.5,
            'timestamp': post['timestamp'] ?? Timestamp.now(),
            'postId':
                post['postId'] ??
                '${contractorDoc.id}_${DateTime.now().millisecondsSinceEpoch}',
            'mediaType':
                post['type'] ?? 'image', // ADDED: Media type for future use
          });
        }
      }

      // Process workers posts
      for (var workerDoc in results[1].docs) {
        final workerData = workerDoc.data();
        final posts = List<Map<String, dynamic>>.from(
          workerData['posts'] ?? [],
        );

        for (var post in posts) {
          allPosts.add({
            'userId': workerDoc.id,
            'userType': 'worker',
            'name': workerData['name'] ?? 'Worker',
            'profileImage':
                workerData['profileImage'] ?? workerData['profileUrl'] ?? '',
            'postUrl':
                post['url'] ??
                post['imageUrl'] ??
                '', // CORRECTED: Use 'url' field
            'description':
                post['description'] ??
                workerData['aboutUs'] ??
                'No description',
            'rating': workerData['rating'] ?? 4.5,
            'timestamp': post['timestamp'] ?? Timestamp.now(),
            'postId':
                post['postId'] ??
                '${workerDoc.id}_${DateTime.now().millisecondsSinceEpoch}',
            'mediaType':
                post['type'] ?? 'image', // ADDED: Media type for future use
          });
        }
      }

      // Sort by timestamp (newest first)
      allPosts.sort((a, b) {
        final aTime = (a['timestamp'] as Timestamp).millisecondsSinceEpoch;
        final bTime = (b['timestamp'] as Timestamp).millisecondsSinceEpoch;
        return bTime.compareTo(aTime); // Descending order
      });

      return allPosts;
    });
  }

  // Alternative stream for old postUrls structure (backward compatibility)
  Stream<List<Map<String, dynamic>>> get combinedPostsStreamLegacy {
    final contractorsStream = _firestore
        .collection('contractors')
        .where('postUrls', isNotEqualTo: [])
        .snapshots();

    final workersStream = _firestore
        .collection('workers')
        .where('postUrls', isNotEqualTo: [])
        .snapshots();

    return StreamZip([contractorsStream, workersStream]).map((results) {
      List<Map<String, dynamic>> allPosts = [];

      // Process contractors posts
      for (var contractorDoc in results[0].docs) {
        final contractorData = contractorDoc.data();
        final postUrls = List<String>.from(contractorData['postUrls'] ?? []);

        for (var postUrl in postUrls) {
          allPosts.add({
            'userId': contractorDoc.id,
            'userType': 'contractor',
            'name': contractorData['name'] ?? 'Contractor',
            'profileImage':
                contractorData['profileImage'] ??
                contractorData['profileUrl'] ??
                '',
            'postUrl': postUrl,
            'description': contractorData['bio'] ?? 'No description',
            'rating': contractorData['rating'] ?? 4.5,
            'timestamp': contractorData['updatedAt'] ?? Timestamp.now(),
            'postId': '${contractorDoc.id}_${postUrl.hashCode}',
            'mediaType': 'image', // Default to image for legacy posts
          });
        }
      }

      // Process workers posts
      for (var workerDoc in results[1].docs) {
        final workerData = workerDoc.data();
        final postUrls = List<String>.from(workerData['postUrls'] ?? []);

        for (var postUrl in postUrls) {
          allPosts.add({
            'userId': workerDoc.id,
            'userType': 'worker',
            'name': workerData['name'] ?? 'Worker',
            'profileImage':
                workerData['profileImage'] ?? workerData['profileUrl'] ?? '',
            'postUrl': postUrl,
            'description': workerData['aboutUs'] ?? 'No description',
            'rating': workerData['rating'] ?? 4.5,
            'timestamp': workerData['updatedAt'] ?? Timestamp.now(),
            'postId': '${workerDoc.id}_${postUrl.hashCode}',
            'mediaType': 'image', // Default to image for legacy posts
          });
        }
      }

      // Sort by timestamp (newest first)
      allPosts.sort((a, b) {
        final aTime = (a['timestamp'] as Timestamp).millisecondsSinceEpoch;
        final bTime = (b['timestamp'] as Timestamp).millisecondsSinceEpoch;
        return bTime.compareTo(aTime);
      });

      return allPosts;
    });
  }

  // NEW: Combined stream that tries both structures
  Stream<List<Map<String, dynamic>>> get combinedPostsStreamUniversal {
    return StreamZip([combinedPostsStream, combinedPostsStreamLegacy]).map((
      results,
    ) {
      // Combine results from both streams
      List<Map<String, dynamic>> allPosts = [];
      allPosts.addAll(results[0]); // New structure posts
      allPosts.addAll(results[1]); // Legacy structure posts

      // Remove duplicates based on postId
      final uniquePosts = <String, Map<String, dynamic>>{};
      for (var post in allPosts) {
        uniquePosts[post['postId']] = post;
      }

      // Sort by timestamp (newest first)
      final sortedPosts = uniquePosts.values.toList();
      sortedPosts.sort((a, b) {
        final aTime = (a['timestamp'] as Timestamp).millisecondsSinceEpoch;
        final bTime = (b['timestamp'] as Timestamp).millisecondsSinceEpoch;
        return bTime.compareTo(aTime);
      });

      return sortedPosts;
    });
  }

  // Search across all collections
  Stream<List<QuerySnapshot>> _searchAll(String query) {
    if (query.isEmpty) return Stream.value([]);

    final usersStream = _firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z')
        .snapshots();

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

    return StreamZip([usersStream, contractorsStream, workersStream]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF2EC),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search services, contractors, or workers...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

            // Show search results or normal homepage
            Expanded(
              child: _searchQuery.isNotEmpty
                  ? _buildSearchResults()
                  : _buildNormalHomepage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return StreamBuilder<List<QuerySnapshot>>(
      stream: _searchAll(_searchQuery),
      builder: (context, snapshot) {
        // Combine all results
        List<QueryDocumentSnapshot> allResults = [];
        if (snapshot.hasData) {
          for (var querySnapshot in snapshot.data!) {
            allResults.addAll(querySnapshot.docs);
          }
        }

        // Show no results message
        if (allResults.isEmpty) {
          return const Center(child: Text('No results found'));
        }

        // Show results
        return ListView.builder(
          itemCount: allResults.length,
          itemBuilder: (context, index) {
            final doc = allResults[index];
            final data = doc.data() as Map<String, dynamic>;
            final collection = doc.reference.path.split('/')[0];

            return _buildSearchResultCard(data, collection);
          },
        );
      },
    );
  }

  Widget _buildSearchResultCard(Map<String, dynamic> data, String collection) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: _getImage(
            data['profileImage'] ?? data['profileUrl'],
          ),
        ),
        title: Text(data['name'] ?? 'No Name'),
        subtitle: Text(data['email'] ?? 'No Email'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getColor(collection),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _getLabel(collection),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildNormalHomepage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Image
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/homepg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              color: Colors.black.withOpacity(0.3),
              child: const Text(
                "Connect, Create,\nGrow your space",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionCard(
                  Icons.nature,
                  "Find\nContractors",
                  const Color.fromARGB(255, 123, 214, 138),
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Explorepage(initialTabIndex: 0),
                      ),
                    );
                  },
                ),
                _buildActionCard(
                  Icons.construction,
                  "Hire\nWorkers",
                  const Color.fromARGB(255, 194, 155, 155),
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Explorepage(initialTabIndex: 1),
                      ),
                    );
                  },
                ),
                _buildActionCard(
                  Icons.post_add,
                  "Create\nYour Design",
                  const Color.fromARGB(255, 191, 201, 191),
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Explorepage(initialTabIndex: 3),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Latest Posts Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Latest Posts from Contractors & Workers",
              style: TextStyle(
                color: Colors.green.shade800,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Real-time Posts Feed from Firestore - UPDATED to use universal stream
          _buildRealTimePosts(),
        ],
      ),
    );
  }

  Widget _buildRealTimePosts() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: combinedPostsStreamUniversal, // Use universal stream
      builder: (context, snapshot) {
        return _buildPostsContent(snapshot);
      },
    );
  }

  Widget _buildPostsContent(
    AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      print('Error loading posts: ${snapshot.error}');
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.red),
            const SizedBox(height: 10),
            Text(
              'Error loading posts: ${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      );
    }

    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            'No posts yet.\nContractors and workers will appear here when they upload posts.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    final posts = snapshot.data!;
    print('Loaded ${posts.length} posts'); // Debug print

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return _buildRealTimePostCard(post);
      },
    );
  }

  Widget _buildRealTimePostCard(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info + User Type Badge
          ListTile(
            leading: CircleAvatar(
              backgroundImage: _getImage(post['profileImage']),
            ),
            title: Text(
              post['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              '${post['userType']} • ${_formatTimestamp(post['timestamp'] as Timestamp)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: post['userType'] == 'contractor'
                    ? Colors.orange
                    : Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                post['userType'] == 'contractor' ? 'Contractor' : 'Worker',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),

          // Single Post Image/Video
          Container(
            height: 300,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                post['postUrl'],
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 50,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Failed to load image',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Description and Rating
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['description'],
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${post['rating']?.toStringAsFixed(1) ?? '4.5'} Rating',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final now = DateTime.now();
    final postTime = timestamp.toDate();
    final difference = now.difference(postTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  ImageProvider _getImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      if (imageUrl.startsWith('http')) {
        return NetworkImage(imageUrl);
      } else if (imageUrl.startsWith('assets/')) {
        return AssetImage(imageUrl);
      }
    }
    return const AssetImage("assets/userprofile.jpeg");
  }

  Color _getColor(String collection) {
    switch (collection) {
      case 'users':
        return Colors.green;
      case 'contractors':
        return Colors.orange;
      case 'workers':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getLabel(String collection) {
    switch (collection) {
      case 'users':
        return 'User';
      case 'contractors':
        return 'Contractor';
      case 'workers':
        return 'Worker';
      default:
        return 'User';
    }
  }

  // Action Card Widget
  Widget _buildActionCard(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 105,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.green.shade800),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
