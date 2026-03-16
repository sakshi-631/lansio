
// // import 'package:flutter/material.dart';
// // import 'package:lansio/View/Contractor/Tender.dart';

// // // --- 1. Data Model for a Client Request ---
// // class ClientRequest {
// //   final String clientName;
// //   final String projectType;
// //   final String location;
// //   final String expectedDuration;
// //   final String requirement;
// //   bool isAccepted; // To track if the request is accepted
// //   bool isRejected; // To track if the request is rejected

// //   ClientRequest({
// //     required this.clientName,
// //     required this.projectType,
// //     required this.location,
// //     required this.expectedDuration,
// //     required this.requirement,
// //     this.isAccepted = false,
// //     this.isRejected = false,
// //   });

// //   // Helper to determine if action buttons should be shown
// //   bool get hasActioned => isAccepted || isRejected;
// // }

// // // --- 2. Main Screen Widget ---
// // class ClientRequestScreen extends StatefulWidget {
// //   const ClientRequestScreen({super.key});

// //   @override
// //   State<ClientRequestScreen> createState() => _ClientRequestScreenState();
// // }

// // class _ClientRequestScreenState extends State<ClientRequestScreen> {
// //   // Sample data for client requests
// //   final List<ClientRequest> requests = [
// //     ClientRequest(
// //       clientName: 'Client Name One',
// //       projectType: 'Garden Modernizing',
// //       location: 'Pune, Maharashtra',
// //       expectedDuration: '2-3 weeks',
// //       requirement: 'Small garden, require flowering plants',
// //     ),
// //     ClientRequest(
// //       clientName: 'Client Name Two',
// //       projectType: 'New Landscape Design',
// //       location: 'Mumbai, Maharashtra',
// //       expectedDuration: '4 weeks',
// //       requirement: 'Large area (500 sq ft), focus on low-maintenance plants.',
// //     ),
// //     ClientRequest(
// //       clientName: 'Client Name Three',
// //       projectType: 'Tree Planting',
// //       location: 'Bangalore, Karnataka',
// //       expectedDuration: '1 week',
// //       requirement: 'Plant 10 fruit trees, specific types: mango, guava, lemon.',
// //     ),
// //   ];

// //   void _handleAccept(int index) {
// //     setState(() {
// //       requests[index].isAccepted = true;
// //       requests[index].isRejected =
// //           false; // Ensure it's not rejected if accepted
// //       // In a real app, you'd also send this status to a backend
// //       _showSnackBar('Request from ${requests[index].clientName} accepted!');
// //     });
// //   }

// //   void _handleReject(int index) {
// //     setState(() {
// //       requests[index].isRejected = true;
// //       requests[index].isAccepted =
// //           false; // Ensure it's not accepted if rejected
// //       // In a real app, you'd also send this status to a backend
// //       _showSnackBar('Request from ${requests[index].clientName} rejected!');
// //     });
// //   }

// //   void _showSnackBar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
// //     );
// //   }

// //   // Define a dummy action for the new button

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // appBar: AppBar(
// //       //   title: const Text('Client Requests', style: TextStyle(color: Colors.white)),
// //       //   backgroundColor: Color(0xFF4C8A4C), // Assuming a green theme
// //       //   iconTheme: IconThemeData(color: Colors.white),
// //       // ),
// //       backgroundColor: Color(0xFFF5F5E9), // Light background color
// //       body: requests.isEmpty
// //           ? const Center(
// //               child: Text(
// //                 'No new client requests.',
// //                 style: TextStyle(fontSize: 16, color: Colors.grey),
// //               ),
// //             )
// //           : ListView.builder(
// //               padding: const EdgeInsets.all(16.0),
// //               itemCount: requests.length,
// //               itemBuilder: (context, index) {
// //                 final request = requests[index];
// //                 return _buildRequestCard(context, request, index);
// //               },
// //             ),
// //     );
// //   }

// //   Widget _buildRequestCard(
// //     BuildContext context,
// //     ClientRequest request,
// //     int index,
// //   ) {
// //     final Color primaryGreen = Color(0xFF4C8A4C); // Theme color
// //     final Color lightGreyBackground = Color(0xFFF0F0F0); // For checkbox circle

// //     return Card(
// //       margin: const EdgeInsets.only(bottom: 16.0),
// //       color: Colors.white,
// //       elevation: 3.0,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Circular icon/placeholder as shown in sketch
// //                 Container(
// //                   width: 36,
// //                   height: 36,
// //                   decoration: BoxDecoration(
// //                     color: lightGreyBackground,
// //                     shape: BoxShape.circle,
// //                     border: Border.all(color: Colors.grey.shade400, width: 1.0),
// //                   ),
// //                   child: Icon(
// //                     Icons.person_outline,
// //                     color: Colors.grey.shade600,
// //                     size: 20,
// //                   ),
// //                 ),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         request.clientName,
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.black87,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Text(
// //                         '- Project Type: ${request.projectType}',
// //                         style: TextStyle(fontSize: 14, color: Colors.black54),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Text(
// //                         '- Location: ${request.location}',
// //                         style: TextStyle(fontSize: 14, color: Colors.black54),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 // Accept/Reject buttons are handled below, here's for initial layout
// //                 // (Empty space or other leading element if needed)
// //               ],
// //             ),
// //             const Divider(height: 24, thickness: 0.5),
// //             Text(
// //               'Expected Duration: ${request.expectedDuration}',
// //               style: TextStyle(fontSize: 14, color: Colors.black87),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               'Requirement:',
// //               style: TextStyle(
// //                 fontSize: 14,
// //                 fontWeight: FontWeight.w600,
// //                 color: Colors.black87,
// //               ),
// //             ),
// //             const SizedBox(height: 4),
// //             // Requirement details in a TextField-like container
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(8.0),
// //               decoration: BoxDecoration(
// //                 color: lightGreyBackground,
// //                 borderRadius: BorderRadius.circular(8.0),
// //                 border: Border.all(color: Colors.grey.shade300),
// //               ),
// //               child: Text(
// //                 request.requirement,
// //                 style: TextStyle(fontSize: 14, color: Colors.black54),
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             // --- Accept/Reject Buttons ---
// //             // Only show buttons if the request hasn't been actioned yet
// //             if (!request.hasActioned)
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.end,
// //                 children: [
// //                   // Accept Button (Check Mark)
// //                   ElevatedButton(
// //                     onPressed: () => _handleAccept(index),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: primaryGreen,
// //                       foregroundColor: Colors.white,
// //                       shape: const CircleBorder(),
// //                       padding: const EdgeInsets.all(10),
// //                       elevation: 3,
// //                     ),
// //                     child: const Icon(Icons.check),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   // Reject Button (Cross Mark)
// //                   ElevatedButton(
// //                     onPressed: () => _handleReject(index),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor:
// //                           Colors.red.shade700, // A clear reject color
// //                       foregroundColor: Colors.white,
// //                       shape: const CircleBorder(),
// //                       padding: const EdgeInsets.all(10),
// //                       elevation: 3,
// //                     ),
// //                     child: const Icon(Icons.close),
// //                   ),
// //                 ],
// //               )
// //             else // Show status and (potentially) a button if actioned
// //               Row(
// //                 mainAxisAlignment: request.isAccepted
// //                     ? MainAxisAlignment.center
// //                     : MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     request.isAccepted
// //                         ? 'Request Accepted'
// //                         : 'Request Rejected',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                       color: request.isAccepted
// //                           ? primaryGreen
// //                           : Colors.red.shade700,
// //                     ),
// //                   ),
// //                   // Add the button ONLY if the request is accepted
// //                   if (request.isAccepted) ...[
// //                     const SizedBox(width: 12),
// //                     ElevatedButton.icon(
// //                       onPressed: () {
// //                         Navigator.of(context).push(
// //                           MaterialPageRoute(
// //                             builder: (context) {
// //                               return Tender(
// //                                 clientName: requests[index].clientName,
// //                                 projectName: requests[index].clientName,
// //                               );
// //                             },
// //                           ),
// //                         );
// //                       },
// //                       icon: const Icon(Icons.send, size: 18),
// //                       label: const Text('Share Tender'),
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: primaryGreen,
// //                         foregroundColor: Colors.white,
// //                         padding: const EdgeInsets.symmetric(
// //                           horizontal: 16,
// //                           vertical: 8,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ],
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // --- 3. Run the App (if you want to test this as a standalone app) ---









// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:lansio/View/Contractor/Tender.dart';

// class ClientRequestScreen extends StatefulWidget {
//   const ClientRequestScreen({super.key});

//   @override
//   State<ClientRequestScreen> createState() => _ClientRequestScreenState();
// }

// class _ClientRequestScreenState extends State<ClientRequestScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final Color primaryGreen = const Color(0xFF4C8A4C);

//   Stream<QuerySnapshot> get _requestStream {
//     final userId = _auth.currentUser?.uid;

//     if (userId == null) {
//       return Stream.empty(); // Return empty stream if no user is logged in
//     }

//     return _firestore
//         .collection('requests')
//         .where('requestedToId', isEqualTo: userId)
//         .orderBy('timestamp', descending: true) // Sort by newest first
//         .snapshots();
//   }

//   Future<Map<String, dynamic>?> _fetchClientData(String clientId) async {
//     if (clientId.isEmpty) return null;
//     try {
//       // Access the /users collection using the client's UID
//       final docSnapshot = await _firestore.collection('users').doc(clientId).get();
//       if (docSnapshot.exists) {
//         return docSnapshot.data();
//       }
//     } catch (e) {
//       print('Error fetching client data for $clientId: $e');
//     }
//     return null;
//   }
  
//   Future<String> _fetchContractorName() async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return 'A Contractor';
//     try {
//       final doc = await _firestore.collection('users').doc(uid).get();
//       return doc.data()?['name'] ?? 'A Contractor';
//     } catch (e) {
//       print('Error fetching contractor name: $e');
//       return 'A Contractor';
//     }
//   }

//   Future<void> _sendNotification(
//       String clientUid, String message, String projectType) async {
//     final contractorName = await _fetchContractorName();

//     try {
//       await _firestore.collection('notifications').add({
//         'requestedToId': clientUid, 
//         'notificationMsg': '$contractorName $message for your $projectType project.',
//         'timestamp': Timestamp.now(),
//         'isRead': false, 
//       });
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }

//   Future<void> _updateRequestStatus(
//     String requestId,
//     String clientUid, 
//     String projectType, 
//     String status,
//   ) async {
//     try {
//       await _firestore.collection('requests').doc(requestId).update({
//         'status': status,
//       });
      
//       final message = status == 'Accepted' ? 'accepted your request' : 'rejected your request';
      
//       // Send notification for Accept/Reject, but not Tender Shared (which is handled in the Tender screen)
//       if (status != 'Tender Shared') { 
//         await _sendNotification(clientUid, message, projectType);
//       }

//       _showSnackBar('Request $status!');
//     } catch (e) {
//       _showSnackBar('Failed to update request status: $e');
//     }
//   }

//   void _handleAccept(String requestId, String clientUid, String projectType) {
//     _updateRequestStatus(requestId, clientUid, projectType, 'Accepted');
//   }

//   void _handleReject(String requestId, String clientUid, String projectType) {
//     _updateRequestStatus(requestId, clientUid, projectType, 'Rejected');
//   }
  
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_auth.currentUser == null) {
//       return const Center(child: Text('Please log in as a contractor to view requests.'));
//     }

//     return Scaffold(
      
//       backgroundColor: const Color(0xFFF5F5E9), // Light background color
      
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _requestStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error loading requests: ${snapshot.error}'));
//           }

//           final requests = snapshot.data?.docs ?? [];

//           if (requests.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No new client requests.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             );
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16.0),
//             itemCount: requests.length,
//             itemBuilder: (context, index) {
//               // Get the document ID and data map
//               final doc = requests[index];
//               final requestId = doc.id;
//               final requestData = doc.data() as Map<String, dynamic>;

//               return _buildRequestCard(context, requestId, requestData);
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildRequestCard(
//     BuildContext context,
//     String requestId,
//     Map<String, dynamic> requestData,
//   ) {
//     // Extract Request Data
//     final String projectType = requestData['projectType'] ?? 'N/A';
//     final String location = requestData['location'] ?? 'N/A';
//     final String expectedDuration = requestData['expectedDuration'] ?? 'Not Specified';
//     final String requirement = requestData['requirements'] ?? 'No details provided.';
//     final String status = requestData['status'] ?? 'Pending';
//     final String requestedById = requestData['requestedById'] ?? ''; // Client's UID

//     final bool isAccepted = status == 'Accepted';
//     final bool isRejected = status == 'Rejected';
//     final bool isPending = status == 'Pending';
//     final bool isTenderShared = status == 'Tender Shared'; 
    
//     // Theme and Status Colors
//     final Color lightGreyBackground = const Color(0xFFF0F0F0);

//     Color statusColor;
//     String statusText;

//     if (isRejected) {
//       statusColor = Colors.red.shade700;
//       statusText = 'Rejected';
//     } else if (isTenderShared) {
//       statusColor = Colors.blue.shade700;
//       statusText = 'Tender Shared';
//     } else if (isAccepted) {
//       statusColor = primaryGreen;
//       statusText = 'Accepted';
//     } else {
//       statusColor = Colors.orange.shade700;
//       statusText = 'Pending';
//     }

//     // --- START FutureBuilder for Client Data ---
//     return FutureBuilder<Map<String, dynamic>?>(
//       future: _fetchClientData(requestedById),
//       builder: (context, clientSnapshot) {
//         // Use client data if available, otherwise use placeholders
//         final String clientName = clientSnapshot.data?['name'] ?? 'Loading Client...';
//         final String clientPhotoUrl = clientSnapshot.data?['profileImage'] ?? '';
        
//         // Show a temporary placeholder if fetching client data is still in progress
//         if (clientSnapshot.connectionState == ConnectionState.waiting && requestedById.isNotEmpty) {
//           return const Center(child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: LinearProgressIndicator(),
//           ));
//         }

//         return Card(
//           margin: const EdgeInsets.only(bottom: 16.0),
//           color: Colors.white,
//           elevation: 3.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             // Use statusColor for the border if not pending
//             side: BorderSide(color: statusColor.withOpacity(isPending ? 0.0 : 0.5), width: 1.0), 
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Avatar/Placeholder
//                     Container(
//                       width: 36,
//                       height: 36,
//                       decoration: BoxDecoration(
//                         color: lightGreyBackground,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.grey.shade400, width: 1.0),
//                       ),
//                       child: clientPhotoUrl.isNotEmpty
//                           ? ClipOval(
//                               child: Image.network(
//                                 clientPhotoUrl,
//                                 fit: BoxFit.cover,
//                                 // Fallback icon on error
//                                 errorBuilder: (context, error, stackTrace) => Icon(Icons.person_outline, color: Colors.grey.shade600, size: 20),
//                               ),
//                             )
//                           : Icon(
//                               Icons.person_outline,
//                               color: Colors.grey.shade600,
//                               size: 20,
//                             ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             clientName, // Dynamic Client Name
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             '- Project Type: $projectType',
//                             style: const TextStyle(fontSize: 14, color: Colors.black54),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             '- Location: $location',
//                             style: const TextStyle(fontSize: 14, color: Colors.black54),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Display Status Chip for all statuses
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: statusColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(6),
//                         border: Border.all(color: statusColor, width: 1),
//                       ),
//                       child: Text(
//                         statusText, // Use statusText defined above
//                         style: TextStyle(
//                           color: statusColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const Divider(height: 24, thickness: 0.5),
//                 Text(
//                   'Expected Duration: $expectedDuration',
//                   style: const TextStyle(fontSize: 14, color: Colors.black87),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Requirement:',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 // Requirement details in a TextField-like container
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: lightGreyBackground,
//                     borderRadius: BorderRadius.circular(8.0),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Text(
//                     requirement,
//                     style: const TextStyle(fontSize: 14, color: Colors.black54),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // --- Action Buttons / Status ---
//                 if (isPending)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () => _handleAccept(requestId, requestedById, projectType),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryGreen,
//                           foregroundColor: Colors.white,
//                           shape: const CircleBorder(),
//                           padding: const EdgeInsets.all(10),
//                           elevation: 3,
//                         ),
//                         child: const Icon(Icons.check),
//                       ),
//                       const SizedBox(width: 12),
//                       ElevatedButton(
//                         onPressed: () => _handleReject(requestId, requestedById, projectType),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red.shade700,
//                           foregroundColor: Colors.white,
//                           shape: const CircleBorder(),
//                           padding: const EdgeInsets.all(10),
//                           elevation: 3,
//                         ),
//                         child: const Icon(Icons.close),
//                       ),
//                     ],
//                   )
//                 // Show Tender button if Accepted AND not yet Shared
//                 else if (isAccepted && !isTenderShared) 
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           // PASS REQUIRED DATA TO TENDER SCREEN
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return Tender(
//                                   clientName: clientName, 
//                                   projectName: projectType,
//                                   requestId: requestId, // Pass Request ID
//                                   requestedById: requestedById, // Pass Client UID
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.send, size: 18),
//                         label: const Text('Share Tender'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryGreen,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 8,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 else
//                   Center(
//                     child: Text(
//                       statusText, // Use dynamic statusText
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: statusColor,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//     // --- END FutureBuilder ---
//   }
// }











// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:lansio/View/Contractor/Tender.dart';

// // // --- 2. Main Screen Widget ---
// // class ClientRequestScreen extends StatefulWidget {
// //   const ClientRequestScreen({super.key});

// //   @override
// //   State<ClientRequestScreen> createState() => _ClientRequestScreenState();
// // }

// // class _ClientRequestScreenState extends State<ClientRequestScreen> {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   // Define the primary theme color
// //   final Color primaryGreen = const Color(0xFF4C8A4C);

// //   // This stream fetches requests where 'requestedToId' matches the current user's UID
// //   Stream<QuerySnapshot> get _requestStream {
// //     final userId = _auth.currentUser?.uid;

// //     if (userId == null) {
// //       return Stream.empty(); // Return empty stream if no user is logged in
// //     }

// //     return _firestore
// //         .collection('requests')
// //         .where('requestedToId', isEqualTo: userId)
// //         .orderBy('timestamp', descending: true) // Sort by newest first
// //         .snapshots();
// //   }

// //   // Function to fetch user data from the 'users' collection
// //   Future<Map<String, dynamic>?> _fetchClientData(String clientId) async {
// //     if (clientId.isEmpty) return null;
// //     try {
// //       // Access the /users collection using the client's UID
// //       final docSnapshot = await _firestore.collection('users').doc(clientId).get();
// //       if (docSnapshot.exists) {
// //         return docSnapshot.data();
// //       }
// //     } catch (e) {
// //       print('Error fetching client data for $clientId: $e');
// //     }
// //     return null;
// //   }
  
// //   // 🆕 ADDED: Function to fetch the current contractor's name for notifications
// //   Future<String> _fetchContractorName() async {
// //     final uid = _auth.currentUser?.uid;
// //     if (uid == null) return 'A Contractor';
// //     try {
// //       final doc = await _firestore.collection('users').doc(uid).get();
// //       return doc.data()?['name'] ?? 'A Contractor';
// //     } catch (e) {
// //       print('Error fetching contractor name: $e');
// //       return 'A Contractor';
// //     }
// //   }

// //   // 🆕 ADDED: Function to send a notification to the client
// //   Future<void> _sendNotification(
// //       String clientUid, String message, String projectType) async {
// //     final contractorName = await _fetchContractorName();

// //     try {
// //       await _firestore.collection('notifications').add({
// //         'requestedToId': clientUid, 
// //         'notificationMsg': '$contractorName $message for your $projectType project.',
// //         'timestamp': Timestamp.now(),
// //         'isRead': false, 
// //       });
// //     } catch (e) {
// //       print('Error sending notification: $e');
// //     }
// //   }

// //   // 🎯 MODIFIED: Update the request status and send a notification
// //   Future<void> _updateRequestStatus(
// //     String requestId,
// //     String clientUid, 
// //     String projectType, 
// //     String status,
// //   ) async {
// //     try {
// //       await _firestore.collection('requests').doc(requestId).update({
// //         'status': status,
// //       });
      
// //       final message = status == 'Accepted' ? 'accepted your request' : 'rejected your request';
      
// //       // Only send notification for Accept/Reject, not Tender Shared (handled elsewhere)
// //       if (status != 'Tender Shared') { 
// //         await _sendNotification(clientUid, message, projectType);
// //       }

// //       _showSnackBar('Request $status!');
// //     } catch (e) {
// //       _showSnackBar('Failed to update request status: $e');
// //     }
// //   }

// //   // 🎯 MODIFIED: Handlers now pass client UID and project type
// //   void _handleAccept(String requestId, String clientUid, String projectType) {
// //     _updateRequestStatus(requestId, clientUid, projectType, 'Accepted');
// //   }

// //   // 🎯 MODIFIED: Handlers now pass client UID and project type
// //   void _handleReject(String requestId, String clientUid, String projectType) {
// //     _updateRequestStatus(requestId, clientUid, projectType, 'Rejected');
// //   }
  
// //   void _showSnackBar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     if (_auth.currentUser == null) {
// //       return const Center(child: Text('Please log in as a contractor to view requests.'));
// //     }

// //     return Scaffold(
      
// //       backgroundColor: const Color(0xFFF5F5E9), // Light background color
      
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: _requestStream,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error loading requests: ${snapshot.error}'));
// //           }

// //           final requests = snapshot.data?.docs ?? [];

// //           if (requests.isEmpty) {
// //             return const Center(
// //               child: Text(
// //                 'No new client requests.',
// //                 style: TextStyle(fontSize: 16, color: Colors.grey),
// //               ),
// //             );
// //           }

// //           return ListView.builder(
// //             padding: const EdgeInsets.all(16.0),
// //             itemCount: requests.length,
// //             itemBuilder: (context, index) {
// //               // Get the document ID and data map
// //               final doc = requests[index];
// //               final requestId = doc.id;
// //               final requestData = doc.data() as Map<String, dynamic>;

// //               return _buildRequestCard(context, requestId, requestData);
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   // UPDATED: Uses FutureBuilder to fetch and display client details
// //   Widget _buildRequestCard(
// //     BuildContext context,
// //     String requestId,
// //     Map<String, dynamic> requestData,
// //   ) {
// //     // Extract Request Data
// //     final String projectType = requestData['projectType'] ?? 'N/A';
// //     final String location = requestData['location'] ?? 'N/A';
// //     final String expectedDuration = requestData['expectedDuration'] ?? 'Not Specified';
// //     final String requirement = requestData['requirements'] ?? 'No details provided.';
// //     final String status = requestData['status'] ?? 'Pending';
// //     final String requestedById = requestData['requestedById'] ?? ''; // 🎯 Client's UID

// //     final bool isAccepted = status == 'Accepted';
// //     final bool isRejected = status == 'Rejected';
// //     final bool isPending = status == 'Pending';
// //     // 🆕 Added check for Tender Shared status from the second file
// //     final bool isTenderShared = status == 'Tender Shared'; 
    
// //     // Theme and Status Colors
// //     final Color lightGreyBackground = const Color(0xFFF0F0F0);

// //     Color statusColor;
// //     String statusText;

// //     if (isRejected) {
// //       statusColor = Colors.red.shade700;
// //       statusText = 'Rejected';
// //     } else if (isTenderShared) {
// //       statusColor = Colors.blue.shade700;
// //       statusText = 'Tender Shared';
// //     } else if (isAccepted) {
// //       statusColor = primaryGreen;
// //       statusText = 'Accepted';
// //     } else {
// //       statusColor = Colors.orange.shade700;
// //       statusText = 'Pending';
// //     }

// //     // --- START FutureBuilder for Client Data ---
// //     return FutureBuilder<Map<String, dynamic>?>(
// //       future: _fetchClientData(requestedById),
// //       builder: (context, clientSnapshot) {
// //         // Use client data if available, otherwise use placeholders
// //         final String clientName = clientSnapshot.data?['name'] ?? 'Loading Client...';
// //         final String clientPhotoUrl = clientSnapshot.data?['profileImage'] ?? '';
        
// //         // Show a temporary placeholder if fetching client data is still in progress
// //         if (clientSnapshot.connectionState == ConnectionState.waiting && requestedById.isNotEmpty) {
// //           return const Center(child: Padding(
// //             padding: EdgeInsets.all(8.0),
// //             child: LinearProgressIndicator(),
// //           ));
// //         }

// //         return Card(
// //           margin: const EdgeInsets.only(bottom: 16.0),
// //           color: Colors.white,
// //           elevation: 3.0,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12.0),
// //             // Use statusColor for the border if not pending
// //             side: BorderSide(color: statusColor.withOpacity(isPending ? 0.0 : 0.5), width: 1.0), 
// //           ),
// //           child: Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Avatar/Placeholder
// //                     Container(
// //                       width: 36,
// //                       height: 36,
// //                       decoration: BoxDecoration(
// //                         color: lightGreyBackground,
// //                         shape: BoxShape.circle,
// //                         border: Border.all(color: Colors.grey.shade400, width: 1.0),
// //                       ),
// //                       child: clientPhotoUrl.isNotEmpty
// //                           ? ClipOval(
// //                               child: Image.network(
// //                                 clientPhotoUrl,
// //                                 fit: BoxFit.cover,
// //                                 // Fallback icon on error
// //                                 errorBuilder: (context, error, stackTrace) => Icon(Icons.person_outline, color: Colors.grey.shade600, size: 20),
// //                               ),
// //                             )
// //                           : Icon(
// //                               Icons.person_outline,
// //                               color: Colors.grey.shade600,
// //                               size: 20,
// //                             ),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             clientName, // 🎯 Dynamic Client Name
// //                             style: const TextStyle(
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.black87,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 4),
// //                           Text(
// //                             '- Project Type: $projectType',
// //                             style: const TextStyle(fontSize: 14, color: Colors.black54),
// //                           ),
// //                           const SizedBox(height: 4),
// //                           Text(
// //                             '- Location: $location',
// //                             style: const TextStyle(fontSize: 14, color: Colors.black54),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     // 🎯 Display Status Chip for all statuses
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                       decoration: BoxDecoration(
// //                         color: statusColor.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(6),
// //                         border: Border.all(color: statusColor, width: 1),
// //                       ),
// //                       child: Text(
// //                         statusText, // Use statusText defined above
// //                         style: TextStyle(
// //                           color: statusColor,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                     )
// //                   ],
// //                 ),
// //                 const Divider(height: 24, thickness: 0.5),
// //                 Text(
// //                   'Expected Duration: $expectedDuration',
// //                   style: const TextStyle(fontSize: 14, color: Colors.black87),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 const Text(
// //                   'Requirement:',
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 4),
// //                 // Requirement details in a TextField-like container
// //                 Container(
// //                   width: double.infinity,
// //                   padding: const EdgeInsets.all(8.0),
// //                   decoration: BoxDecoration(
// //                     color: lightGreyBackground,
// //                     borderRadius: BorderRadius.circular(8.0),
// //                     border: Border.all(color: Colors.grey.shade300),
// //                   ),
// //                   child: Text(
// //                     requirement,
// //                     style: const TextStyle(fontSize: 14, color: Colors.black54),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 16),
// //                 // --- Action Buttons / Status ---
// //                 if (isPending)
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.end,
// //                     children: [
// //                       ElevatedButton(
// //                         // 🎯 PASS REQUIRED DATA
// //                         onPressed: () => _handleAccept(requestId, requestedById, projectType),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: primaryGreen,
// //                           foregroundColor: Colors.white,
// //                           shape: const CircleBorder(),
// //                           padding: const EdgeInsets.all(10),
// //                           elevation: 3,
// //                         ),
// //                         child: const Icon(Icons.check),
// //                       ),
// //                       const SizedBox(width: 12),
// //                       ElevatedButton(
// //                         // 🎯 PASS REQUIRED DATA
// //                         onPressed: () => _handleReject(requestId, requestedById, projectType),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.red.shade700,
// //                           foregroundColor: Colors.white,
// //                           shape: const CircleBorder(),
// //                           padding: const EdgeInsets.all(10),
// //                           elevation: 3,
// //                         ),
// //                         child: const Icon(Icons.close),
// //                       ),
// //                     ],
// //                   )
// //                 // 🎯 Modified condition to only show Tender button if Accepted AND not yet Shared
// //                 else if (isAccepted && !isTenderShared) 
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       ElevatedButton.icon(
// //                         onPressed: () {
// //                           // 🎯 PASS REQUIRED DATA TO TENDER SCREEN
// //                           Navigator.of(context).push(
// //                             MaterialPageRoute(
// //                               builder: (context) {
// //                                 return Tender(
// //                                   clientName: clientName, 
// //                                   projectName: projectType,
// //                                   requestId: requestId,      // 🆕 Pass Request ID
// //                                   requestedById: requestedById, // 🆕 Pass Client UID
// //                                 );
// //                               },
// //                             ),
// //                           );
// //                         },
// //                         icon: const Icon(Icons.send, size: 18),
// //                         label: const Text('Share Tender'),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: primaryGreen,
// //                           foregroundColor: Colors.white,
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: 16,
// //                             vertical: 8,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   )
// //                 else
// //                   Center(
// //                     child: Text(
// //                       statusText, // Use dynamic statusText
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                         color: statusColor,
// //                       ),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //     // --- END FutureBuilder ---
// //   }
// // }







// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:lansio/View/Contractor/Tender.dart';

// class ClientRequestScreen extends StatefulWidget {
//   const ClientRequestScreen({super.key});

//   @override
//   State<ClientRequestScreen> createState() => _ClientRequestScreenState();
// }

// class _ClientRequestScreenState extends State<ClientRequestScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final Color primaryGreen = const Color(0xFF4C8A4C);

//   Stream<QuerySnapshot> get _requestStream {
//     final userId = _auth.currentUser?.uid;

//     if (userId == null) {
//       return Stream.empty(); // Return empty stream if no user is logged in
//     }

//     return _firestore
//         .collection('requests')
//         .where('requestedToId', isEqualTo: userId)
//         .orderBy('timestamp', descending: true) // Sort by newest first
//         .snapshots();
//   }

//   Future<Map<String, dynamic>?> _fetchClientData(String clientId) async {
//     if (clientId.isEmpty) return null;
//     try {
//       // Access the /users collection using the client's UID
//       final docSnapshot = await _firestore.collection('users').doc(clientId).get();
//       if (docSnapshot.exists) {
//         return docSnapshot.data();
//       }
//     } catch (e) {
//       print('Error fetching client data for $clientId: $e');
//     }
//     return null;
//   }
  
//   Future<String> _fetchContractorName() async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return 'A Contractor';
//     try {
//       final doc = await _firestore.collection('users').doc(uid).get();
//       return doc.data()?['name'] ?? 'A Contractor';
//     } catch (e) {
//       print('Error fetching contractor name: $e');
//       return 'A Contractor';
//     }
//   }

//   Future<void> _sendNotification(
//       String clientUid, String message, String projectType) async {
//     final contractorName = await _fetchContractorName();

//     try {
//       await _firestore.collection('notifications').add({
//         'requestedToId': clientUid, 
//         'notificationMsg': '$contractorName $message for your $projectType project.',
//         'timestamp': Timestamp.now(),
//         'isRead': false, 
//       });
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }

//   Future<void> _updateRequestStatus(
//     String requestId,
//     String clientUid, 
//     String projectType, 
//     String status,
//   ) async {
//     try {
//       await _firestore.collection('requests').doc(requestId).update({
//         'status': status,
//       });
      
//       final message = status == 'Accepted' ? 'accepted your request' : 'rejected your request';
      
//       // Send notification for Accept/Reject, but not Tender Shared (which is handled in the Tender screen)
//       if (status != 'Tender Shared') { 
//         await _sendNotification(clientUid, message, projectType);
//       }

//       _showSnackBar('Request $status!');
//     } catch (e) {
//       _showSnackBar('Failed to update request status: $e');
//     }
//   }

//   void _handleAccept(String requestId, String clientUid, String projectType) {
//     _updateRequestStatus(requestId, clientUid, projectType, 'Accepted');
//   }

//   void _handleReject(String requestId, String clientUid, String projectType) {
//     _updateRequestStatus(requestId, clientUid, projectType, 'Rejected');
//   }
  
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_auth.currentUser == null) {
//       return const Center(child: Text('Please log in as a contractor to view requests.'));
//     }

//     return Scaffold(
      
//       backgroundColor: const Color(0xFFF5F5E9), // Light background color
      
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _requestStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error loading requests: ${snapshot.error}'));
//           }

//           final requests = snapshot.data?.docs ?? [];

//           if (requests.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No new client requests.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             );
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16.0),
//             itemCount: requests.length,
//             itemBuilder: (context, index) {
//               // Get the document ID and data map
//               final doc = requests[index];
//               final requestId = doc.id;
//               final requestData = doc.data() as Map<String, dynamic>;

//               return _buildRequestCard(context, requestId, requestData);
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildRequestCard(
//     BuildContext context,
//     String requestId,
//     Map<String, dynamic> requestData,
//   ) {
//     // Extract Request Data
//     final String projectType = requestData['projectType'] ?? 'N/A';
//     final String location = requestData['location'] ?? 'N/A';
//     final String expectedDuration = requestData['expectedDuration'] ?? 'Not Specified';
//     final String requirement = requestData['requirements'] ?? 'No details provided.';
//     final String status = requestData['status'] ?? 'Pending';
//     final String requestedById = requestData['requestedById'] ?? ''; // Client's UID

//     final bool isAccepted = status == 'Accepted';
//     final bool isRejected = status == 'Rejected';
//     final bool isPending = status == 'Pending';
//     final bool isTenderShared = status == 'Tender Shared'; 
    
//     // Theme and Status Colors
//     final Color lightGreyBackground = const Color(0xFFF0F0F0);

//     Color statusColor;
//     String statusText;

//     if (isRejected) {
//       statusColor = Colors.red.shade700;
//       statusText = 'Rejected';
//     } else if (isTenderShared) {
//       statusColor = Colors.blue.shade700;
//       statusText = 'Tender Shared';
//     } else if (isAccepted) {
//       statusColor = primaryGreen;
//       statusText = 'Accepted';
//     } else {
//       statusColor = Colors.orange.shade700;
//       statusText = 'Pending';
//     }

//     // --- START FutureBuilder for Client Data ---
//     return FutureBuilder<Map<String, dynamic>?>(
//       future: _fetchClientData(requestedById),
//       builder: (context, clientSnapshot) {
//         // Use client data if available, otherwise use placeholders
//         final String clientName = clientSnapshot.data?['name'] ?? 'Loading Client...';
//         final String clientPhotoUrl = clientSnapshot.data?['profileImage'] ?? '';
        
//         // Show a temporary placeholder if fetching client data is still in progress
//         if (clientSnapshot.connectionState == ConnectionState.waiting && requestedById.isNotEmpty) {
//           return const Center(child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: LinearProgressIndicator(),
//           ));
//         }

//         return Card(
//           margin: const EdgeInsets.only(bottom: 16.0),
//           color: Colors.white,
//           elevation: 3.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             // Use statusColor for the border if not pending
//             side: BorderSide(color: statusColor.withOpacity(isPending ? 0.0 : 0.5), width: 1.0), 
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Avatar/Placeholder
//                     Container(
//                       width: 36,
//                       height: 36,
//                       decoration: BoxDecoration(
//                         color: lightGreyBackground,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.grey.shade400, width: 1.0),
//                       ),
//                       child: clientPhotoUrl.isNotEmpty
//                           ? ClipOval(
//                               child: Image.network(
//                                 clientPhotoUrl,
//                                 fit: BoxFit.cover,
//                                 // Fallback icon on error
//                                 errorBuilder: (context, error, stackTrace) => Icon(Icons.person_outline, color: Colors.grey.shade600, size: 20),
//                               ),
//                             )
//                           : Icon(
//                               Icons.person_outline,
//                               color: Colors.grey.shade600,
//                               size: 20,
//                             ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             clientName, // Dynamic Client Name
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             '- Project Type: $projectType',
//                             style: const TextStyle(fontSize: 14, color: Colors.black54),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             '- Location: $location',
//                             style: const TextStyle(fontSize: 14, color: Colors.black54),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Display Status Chip for all statuses
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: statusColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(6),
//                         border: Border.all(color: statusColor, width: 1),
//                       ),
//                       child: Text(
//                         statusText, // Use statusText defined above
//                         style: TextStyle(
//                           color: statusColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const Divider(height: 24, thickness: 0.5),
//                 Text(
//                   'Expected Duration: $expectedDuration',
//                   style: const TextStyle(fontSize: 14, color: Colors.black87),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Requirement:',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 // Requirement details in a TextField-like container
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: lightGreyBackground,
//                     borderRadius: BorderRadius.circular(8.0),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Text(
//                     requirement,
//                     style: const TextStyle(fontSize: 14, color: Colors.black54),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // --- Action Buttons / Status ---
//                 if (isPending)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () => _handleAccept(requestId, requestedById, projectType),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryGreen,
//                           foregroundColor: Colors.white,
//                           shape: const CircleBorder(),
//                           padding: const EdgeInsets.all(10),
//                           elevation: 3,
//                         ),
//                         child: const Icon(Icons.check),
//                       ),
//                       const SizedBox(width: 12),
//                       ElevatedButton(
//                         onPressed: () => _handleReject(requestId, requestedById, projectType),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red.shade700,
//                           foregroundColor: Colors.white,
//                           shape: const CircleBorder(),
//                           padding: const EdgeInsets.all(10),
//                           elevation: 3,
//                         ),
//                         child: const Icon(Icons.close),
//                       ),
//                     ],
//                   )
//                 // Show Tender button if Accepted AND not yet Shared
//                 else if (isAccepted && !isTenderShared) 
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           // PASS REQUIRED DATA TO TENDER SCREEN
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return Tender(
//                                   clientName: clientName, 
//                                   projectName: projectType,
//                                   requestId: requestId, // Pass Request ID
//                                   requestedById: requestedById, // Pass Client UID
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.send, size: 18),
//                         label: const Text('Share Tender'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryGreen,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 8,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 else
//                   Center(
//                     child: Text(
//                       statusText, // Use dynamic statusText
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: statusColor,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//     // --- END FutureBuilder ---
//   }
// }











// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:lansio/View/Contractor/Tender.dart';

// // // --- 2. Main Screen Widget ---
// // class ClientRequestScreen extends StatefulWidget {
// //   const ClientRequestScreen({super.key});

// //   @override
// //   State<ClientRequestScreen> createState() => _ClientRequestScreenState();
// // }

// // class _ClientRequestScreenState extends State<ClientRequestScreen> {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   // Define the primary theme color
// //   final Color primaryGreen = const Color(0xFF4C8A4C);

// //   // This stream fetches requests where 'requestedToId' matches the current user's UID
// //   Stream<QuerySnapshot> get _requestStream {
// //     final userId = _auth.currentUser?.uid;

// //     if (userId == null) {
// //       return Stream.empty(); // Return empty stream if no user is logged in
// //     }

// //     return _firestore
// //         .collection('requests')
// //         .where('requestedToId', isEqualTo: userId)
// //         .orderBy('timestamp', descending: true) // Sort by newest first
// //         .snapshots();
// //   }

// //   // Function to fetch user data from the 'users' collection
// //   Future<Map<String, dynamic>?> _fetchClientData(String clientId) async {
// //     if (clientId.isEmpty) return null;
// //     try {
// //       // Access the /users collection using the client's UID
// //       final docSnapshot = await _firestore.collection('users').doc(clientId).get();
// //       if (docSnapshot.exists) {
// //         return docSnapshot.data();
// //       }
// //     } catch (e) {
// //       print('Error fetching client data for $clientId: $e');
// //     }
// //     return null;
// //   }
  
// //   // 🆕 ADDED: Function to fetch the current contractor's name for notifications
// //   Future<String> _fetchContractorName() async {
// //     final uid = _auth.currentUser?.uid;
// //     if (uid == null) return 'A Contractor';
// //     try {
// //       final doc = await _firestore.collection('users').doc(uid).get();
// //       return doc.data()?['name'] ?? 'A Contractor';
// //     } catch (e) {
// //       print('Error fetching contractor name: $e');
// //       return 'A Contractor';
// //     }
// //   }

// //   // 🆕 ADDED: Function to send a notification to the client
// //   Future<void> _sendNotification(
// //       String clientUid, String message, String projectType) async {
// //     final contractorName = await _fetchContractorName();

// //     try {
// //       await _firestore.collection('notifications').add({
// //         'requestedToId': clientUid, 
// //         'notificationMsg': '$contractorName $message for your $projectType project.',
// //         'timestamp': Timestamp.now(),
// //         'isRead': false, 
// //       });
// //     } catch (e) {
// //       print('Error sending notification: $e');
// //     }
// //   }

// //   // 🎯 MODIFIED: Update the request status and send a notification
// //   Future<void> _updateRequestStatus(
// //     String requestId,
// //     String clientUid, 
// //     String projectType, 
// //     String status,
// //   ) async {
// //     try {
// //       await _firestore.collection('requests').doc(requestId).update({
// //         'status': status,
// //       });
      
// //       final message = status == 'Accepted' ? 'accepted your request' : 'rejected your request';
      
// //       // Only send notification for Accept/Reject, not Tender Shared (handled elsewhere)
// //       if (status != 'Tender Shared') { 
// //         await _sendNotification(clientUid, message, projectType);
// //       }

// //       _showSnackBar('Request $status!');
// //     } catch (e) {
// //       _showSnackBar('Failed to update request status: $e');
// //     }
// //   }

// //   // 🎯 MODIFIED: Handlers now pass client UID and project type
// //   void _handleAccept(String requestId, String clientUid, String projectType) {
// //     _updateRequestStatus(requestId, clientUid, projectType, 'Accepted');
// //   }

// //   // 🎯 MODIFIED: Handlers now pass client UID and project type
// //   void _handleReject(String requestId, String clientUid, String projectType) {
// //     _updateRequestStatus(requestId, clientUid, projectType, 'Rejected');
// //   }
  
// //   void _showSnackBar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     if (_auth.currentUser == null) {
// //       return const Center(child: Text('Please log in as a contractor to view requests.'));
// //     }

// //     return Scaffold(
      
// //       backgroundColor: const Color(0xFFF5F5E9), // Light background color
      
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: _requestStream,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error loading requests: ${snapshot.error}'));
// //           }

// //           final requests = snapshot.data?.docs ?? [];

// //           if (requests.isEmpty) {
// //             return const Center(
// //               child: Text(
// //                 'No new client requests.',
// //                 style: TextStyle(fontSize: 16, color: Colors.grey),
// //               ),
// //             );
// //           }

// //           return ListView.builder(
// //             padding: const EdgeInsets.all(16.0),
// //             itemCount: requests.length,
// //             itemBuilder: (context, index) {
// //               // Get the document ID and data map
// //               final doc = requests[index];
// //               final requestId = doc.id;
// //               final requestData = doc.data() as Map<String, dynamic>;

// //               return _buildRequestCard(context, requestId, requestData);
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   // UPDATED: Uses FutureBuilder to fetch and display client details
// //   Widget _buildRequestCard(
// //     BuildContext context,
// //     String requestId,
// //     Map<String, dynamic> requestData,
// //   ) {
// //     // Extract Request Data
// //     final String projectType = requestData['projectType'] ?? 'N/A';
// //     final String location = requestData['location'] ?? 'N/A';
// //     final String expectedDuration = requestData['expectedDuration'] ?? 'Not Specified';
// //     final String requirement = requestData['requirements'] ?? 'No details provided.';
// //     final String status = requestData['status'] ?? 'Pending';
// //     final String requestedById = requestData['requestedById'] ?? ''; // 🎯 Client's UID

// //     final bool isAccepted = status == 'Accepted';
// //     final bool isRejected = status == 'Rejected';
// //     final bool isPending = status == 'Pending';
// //     // 🆕 Added check for Tender Shared status from the second file
// //     final bool isTenderShared = status == 'Tender Shared'; 
    
// //     // Theme and Status Colors
// //     final Color lightGreyBackground = const Color(0xFFF0F0F0);

// //     Color statusColor;
// //     String statusText;

// //     if (isRejected) {
// //       statusColor = Colors.red.shade700;
// //       statusText = 'Rejected';
// //     } else if (isTenderShared) {
// //       statusColor = Colors.blue.shade700;
// //       statusText = 'Tender Shared';
// //     } else if (isAccepted) {
// //       statusColor = primaryGreen;
// //       statusText = 'Accepted';
// //     } else {
// //       statusColor = Colors.orange.shade700;
// //       statusText = 'Pending';
// //     }

// //     // --- START FutureBuilder for Client Data ---
// //     return FutureBuilder<Map<String, dynamic>?>(
// //       future: _fetchClientData(requestedById),
// //       builder: (context, clientSnapshot) {
// //         // Use client data if available, otherwise use placeholders
// //         final String clientName = clientSnapshot.data?['name'] ?? 'Loading Client...';
// //         final String clientPhotoUrl = clientSnapshot.data?['profileImage'] ?? '';
        
// //         // Show a temporary placeholder if fetching client data is still in progress
// //         if (clientSnapshot.connectionState == ConnectionState.waiting && requestedById.isNotEmpty) {
// //           return const Center(child: Padding(
// //             padding: EdgeInsets.all(8.0),
// //             child: LinearProgressIndicator(),
// //           ));
// //         }

// //         return Card(
// //           margin: const EdgeInsets.only(bottom: 16.0),
// //           color: Colors.white,
// //           elevation: 3.0,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12.0),
// //             // Use statusColor for the border if not pending
// //             side: BorderSide(color: statusColor.withOpacity(isPending ? 0.0 : 0.5), width: 1.0), 
// //           ),
// //           child: Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Avatar/Placeholder
// //                     Container(
// //                       width: 36,
// //                       height: 36,
// //                       decoration: BoxDecoration(
// //                         color: lightGreyBackground,
// //                         shape: BoxShape.circle,
// //                         border: Border.all(color: Colors.grey.shade400, width: 1.0),
// //                       ),
// //                       child: clientPhotoUrl.isNotEmpty
// //                           ? ClipOval(
// //                               child: Image.network(
// //                                 clientPhotoUrl,
// //                                 fit: BoxFit.cover,
// //                                 // Fallback icon on error
// //                                 errorBuilder: (context, error, stackTrace) => Icon(Icons.person_outline, color: Colors.grey.shade600, size: 20),
// //                               ),
// //                             )
// //                           : Icon(
// //                               Icons.person_outline,
// //                               color: Colors.grey.shade600,
// //                               size: 20,
// //                             ),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             clientName, // 🎯 Dynamic Client Name
// //                             style: const TextStyle(
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.black87,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 4),
// //                           Text(
// //                             '- Project Type: $projectType',
// //                             style: const TextStyle(fontSize: 14, color: Colors.black54),
// //                           ),
// //                           const SizedBox(height: 4),
// //                           Text(
// //                             '- Location: $location',
// //                             style: const TextStyle(fontSize: 14, color: Colors.black54),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     // 🎯 Display Status Chip for all statuses
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                       decoration: BoxDecoration(
// //                         color: statusColor.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(6),
// //                         border: Border.all(color: statusColor, width: 1),
// //                       ),
// //                       child: Text(
// //                         statusText, // Use statusText defined above
// //                         style: TextStyle(
// //                           color: statusColor,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                     )
// //                   ],
// //                 ),
// //                 const Divider(height: 24, thickness: 0.5),
// //                 Text(
// //                   'Expected Duration: $expectedDuration',
// //                   style: const TextStyle(fontSize: 14, color: Colors.black87),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 const Text(
// //                   'Requirement:',
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 4),
// //                 // Requirement details in a TextField-like container
// //                 Container(
// //                   width: double.infinity,
// //                   padding: const EdgeInsets.all(8.0),
// //                   decoration: BoxDecoration(
// //                     color: lightGreyBackground,
// //                     borderRadius: BorderRadius.circular(8.0),
// //                     border: Border.all(color: Colors.grey.shade300),
// //                   ),
// //                   child: Text(
// //                     requirement,
// //                     style: const TextStyle(fontSize: 14, color: Colors.black54),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 16),
// //                 // --- Action Buttons / Status ---
// //                 if (isPending)
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.end,
// //                     children: [
// //                       ElevatedButton(
// //                         // 🎯 PASS REQUIRED DATA
// //                         onPressed: () => _handleAccept(requestId, requestedById, projectType),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: primaryGreen,
// //                           foregroundColor: Colors.white,
// //                           shape: const CircleBorder(),
// //                           padding: const EdgeInsets.all(10),
// //                           elevation: 3,
// //                         ),
// //                         child: const Icon(Icons.check),
// //                       ),
// //                       const SizedBox(width: 12),
// //                       ElevatedButton(
// //                         // 🎯 PASS REQUIRED DATA
// //                         onPressed: () => _handleReject(requestId, requestedById, projectType),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.red.shade700,
// //                           foregroundColor: Colors.white,
// //                           shape: const CircleBorder(),
// //                           padding: const EdgeInsets.all(10),
// //                           elevation: 3,
// //                         ),
// //                         child: const Icon(Icons.close),
// //                       ),
// //                     ],
// //                   )
// //                 // 🎯 Modified condition to only show Tender button if Accepted AND not yet Shared
// //                 else if (isAccepted && !isTenderShared) 
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       ElevatedButton.icon(
// //                         onPressed: () {
// //                           // 🎯 PASS REQUIRED DATA TO TENDER SCREEN
// //                           Navigator.of(context).push(
// //                             MaterialPageRoute(
// //                               builder: (context) {
// //                                 return Tender(
// //                                   clientName: clientName, 
// //                                   projectName: projectType,
// //                                   requestId: requestId,      // 🆕 Pass Request ID
// //                                   requestedById: requestedById, // 🆕 Pass Client UID
// //                                 );
// //                               },
// //                             ),
// //                           );
// //                         },
// //                         icon: const Icon(Icons.send, size: 18),
// //                         label: const Text('Share Tender'),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: primaryGreen,
// //                           foregroundColor: Colors.white,
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: 16,
// //                             vertical: 8,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   )
// //                 else
// //                   Center(
// //                     child: Text(
// //                       statusText, // Use dynamic statusText
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                         color: statusColor,
// //                       ),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //     // --- END FutureBuilder ---
// //   }
// // }








import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lansio/View/Contractor/Tender.dart';

class ClientRequestScreen extends StatefulWidget {
  const ClientRequestScreen({super.key});

  @override
  State<ClientRequestScreen> createState() => _ClientRequestScreenState();
}

class _ClientRequestScreenState extends State<ClientRequestScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Color primaryGreen = const Color(0xFF4C8A4C);

  Stream<QuerySnapshot> get _requestStream {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      return Stream.empty(); // Return empty stream if no user is logged in
    }

    return _firestore
        .collection('requests')
        .where('requestedToId', isEqualTo: userId)
        .orderBy('timestamp', descending: true) // Sort by newest first
        .snapshots();
  }

  Future<Map<String, dynamic>?> _fetchClientData(String clientId) async {
    if (clientId.isEmpty) return null;
    try {
      // Access the /users collection using the client's UID
      final docSnapshot = await _firestore.collection('users').doc(clientId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      }
    } catch (e) {
      print('Error fetching client data for $clientId: $e');
    }
    return null;
  }
  
  Future<String> _fetchContractorName() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return 'A Contractor';
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data()?['name'] ?? 'A Contractor';
    } catch (e) {
      print('Error fetching contractor name: $e');
      return 'A Contractor';
    }
  }

  Future<void> _sendNotification(
      String clientUid, String message, String projectType) async {
    final contractorName = await _fetchContractorName();

    try {
      await _firestore.collection('notifications').add({
        'requestedToId': clientUid, 
        'notificationMsg': '$contractorName $message for your $projectType project.',
        'timestamp': Timestamp.now(),
        'isRead': false, 
      });
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  Future<void> _updateRequestStatus(
    String requestId,
    String clientUid, 
    String projectType, 
    String status,
  ) async {
    try {
      await _firestore.collection('requests').doc(requestId).update({
        'status': status,
      });
      
      final message = status == 'Accepted' ? 'accepted your request' : 'rejected your request';
      
      // Send notification for Accept/Reject, but not Tender Shared (which is handled in the Tender screen)
      if (status != 'Tender Shared') { 
        await _sendNotification(clientUid, message, projectType);
      }

      _showSnackBar('Request $status!');
    } catch (e) {
      _showSnackBar('Failed to update request status: $e');
    }
  }

  void _handleAccept(String requestId, String clientUid, String projectType) {
    _updateRequestStatus(requestId, clientUid, projectType, 'Accepted');
  }

  void _handleReject(String requestId, String clientUid, String projectType) {
    _updateRequestStatus(requestId, clientUid, projectType, 'Rejected');
  }
  
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser == null) {
      return const Center(child: Text('Please log in as a contractor to view requests.'));
    }

    return Scaffold(
      
      backgroundColor: const Color(0xFFF5F5E9), // Light background color
      
      body: StreamBuilder<QuerySnapshot>(
        stream: _requestStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading requests: ${snapshot.error}'));
          }

          final requests = snapshot.data?.docs ?? [];

          if (requests.isEmpty) {
            return const Center(
              child: Text(
                'No new client requests.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              // Get the document ID and data map
              final doc = requests[index];
              final requestId = doc.id;
              final requestData = doc.data() as Map<String, dynamic>;

              return _buildRequestCard(context, requestId, requestData);
            },
          );
        },
      ),
    );
  }

  Widget _buildRequestCard(
    BuildContext context,
    String requestId,
    Map<String, dynamic> requestData,
  ) {
    // Extract Request Data
    final String projectType = requestData['projectType'] ?? 'N/A';
    final String location = requestData['location'] ?? 'N/A';
    final String expectedDuration = requestData['expectedDuration'] ?? 'Not Specified';
    final String requirement = requestData['requirements'] ?? 'No details provided.';
    final String status = requestData['status'] ?? 'Pending';
    final String requestedById = requestData['requestedById'] ?? ''; // Client's UID

    final bool isAccepted = status == 'Accepted';
    final bool isRejected = status == 'Rejected';
    final bool isPending = status == 'Pending';
    final bool isTenderShared = status == 'Tender Shared'; 
    
    // Theme and Status Colors
    final Color lightGreyBackground = const Color(0xFFF0F0F0);

    Color statusColor;
    String statusText;

    if (isRejected) {
      statusColor = Colors.red.shade700;
      statusText = 'Rejected';
    } else if (isTenderShared) {
      statusColor = Colors.blue.shade700;
      statusText = 'Tender Shared';
    } else if (isAccepted) {
      statusColor = primaryGreen;
      statusText = 'Accepted';
    } else {
      statusColor = Colors.orange.shade700;
      statusText = 'Pending';
    }

    // --- START FutureBuilder for Client Data ---
    return FutureBuilder<Map<String, dynamic>?>(
      future: _fetchClientData(requestedById),
      builder: (context, clientSnapshot) {
        // Use client data if available, otherwise use placeholders
        final String clientName = clientSnapshot.data?['name'] ?? 'Loading Client...';
        final String clientPhotoUrl = clientSnapshot.data?['profileImage'] ?? '';
        
        // Show a temporary placeholder if fetching client data is still in progress
        if (clientSnapshot.connectionState == ConnectionState.waiting && requestedById.isNotEmpty) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: LinearProgressIndicator(),
          ));
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          color: Colors.white,
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            // Use statusColor for the border if not pending
            side: BorderSide(color: statusColor.withOpacity(isPending ? 0.0 : 0.5), width: 1.0), 
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar/Placeholder
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: lightGreyBackground,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade400, width: 1.0),
                      ),
                      child: clientPhotoUrl.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                clientPhotoUrl,
                                fit: BoxFit.cover,
                                // Fallback icon on error
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.person_outline, color: Colors.grey.shade600, size: 20),
                              ),
                            )
                          : Icon(
                              Icons.person_outline,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clientName, // Dynamic Client Name
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '- Project Type: $projectType',
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '- Location: $location',
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    // Display Status Chip for all statuses
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: statusColor, width: 1),
                      ),
                      child: Text(
                        statusText, // Use statusText defined above
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(height: 24, thickness: 0.5),
                Text(
                  'Expected Duration: $expectedDuration',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Requirement:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                // Requirement details in a TextField-like container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: lightGreyBackground,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    requirement,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 16),
                // --- Action Buttons / Status ---
                if (isPending)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => _handleAccept(requestId, requestedById, projectType),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          elevation: 3,
                        ),
                        child: const Icon(Icons.check),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => _handleReject(requestId, requestedById, projectType),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          foregroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          elevation: 3,
                        ),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  )
                // Show Tender button if Accepted AND not yet Shared
                else if (isAccepted && !isTenderShared) 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // PASS REQUIRED DATA TO TENDER SCREEN
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Tender(
                                  clientName: clientName, 
                                  projectName: projectType,
                                  requestId: requestId, // Pass Request ID
                                  requestedById: requestedById, // Pass Client UID
                                );
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.send, size: 18),
                        label: const Text('Share Tender'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Center(
                    child: Text(
                      statusText, // Use dynamic statusText
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
    // --- END FutureBuilder ---
  }
}
