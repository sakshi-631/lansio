// import 'package:flutter/material.dart';

// // --- Notification Data Model (define once in your file) ---
// class NotificationItem {
//   final String title;
//   final String time;
//   bool isRead;

//   NotificationItem({
//     required this.title,
//     required this.time,
//     this.isRead = false,
//   });
// }

// // --- Notification Screen Implementation ---
// class ContractorNotification extends StatefulWidget {
//   const ContractorNotification({super.key});

//   @override
//   State<ContractorNotification> createState() => _ContractorNotificationState();
// }

// class _ContractorNotificationState extends State<ContractorNotification> {
//   // Sample Data matching the sketch
//   final List<NotificationItem> _notifications = [
//     NotificationItem(
//       title: 'New Service Request',
//       time: '10 min ago',
//       isRead: false,
//     ),
//     NotificationItem(
//       title: 'Payment Confirmation',
//       time: '1 hour ago',
//       isRead: true,
//     ),
//     NotificationItem(
//       title: 'Feedback Received',
//       time: 'Yesterday',
//       isRead: false,
//     ),
//     NotificationItem(
//       title: 'Job Accepted/Rejected',
//       time: '2 days ago',
//       isRead: true,
//     ),
//     NotificationItem(
//       title: 'Contract Update',
//       time: '3 days ago',
//       isRead: false,
//     ),
//   ];

//   // Function to remove the item from the list
//   void _removeNotification(int index) {
//     setState(() {
//       final dismissedItem = _notifications.removeAt(index);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${dismissedItem.title} removed'),
//           action: SnackBarAction(
//             label: 'UNDO',
//             onPressed: () {
//               // Re-insert the item if the user clicks UNDO
//               setState(() {
//                 _notifications.insert(index, dismissedItem);
//               });
//             },
//           ),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       backgroundColor: Colors.grey.shade50, // Light background for contrast
//       body: _notifications.isEmpty
//           ? const Center(
//               child: Text(
//                 'No new notifications.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             )
//           : ListView.builder(
//               itemCount: _notifications.length,
//               itemBuilder: (context, index) {
//                 final item = _notifications[index];

//                 // --- Dismissible Widget for Swipe-to-Remove ---
//                 return Dismissible(
//                   key: Key(
//                     item.title + item.time,
//                   ), // Unique key for Dismissible
//                   direction: DismissDirection.startToEnd, // Only swipe right
//                   // The background shown during the swipe
//                   background: Container(
//                     color: Colors.red.shade700,
//                     alignment: Alignment.centerLeft,
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: const Icon(Icons.delete, color: Colors.white),
//                   ),

//                   // Action when the item is dismissed
//                   onDismissed: (direction) {
//                     _removeNotification(index);
//                   },

//                   // --- Notification Card ---
//                   child: NotificationCard(
//                     item: item,
//                     onCheckboxChanged: (bool? newValue) {
//                       setState(() {
//                         item.isRead = newValue ?? false;
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// // --- 3. Individual Notification Card Widget ---
// class NotificationCard extends StatelessWidget {
//   final NotificationItem item;
//   final ValueChanged<bool?> onCheckboxChanged;

//   const NotificationCard({
//     super.key,
//     required this.item,
//     required this.onCheckboxChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // The visual style of the box around the text in your sketch
//     final Color borderColor = item.isRead
//         ? Colors.grey.shade300
//         : Colors.green.shade700;

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.0),
//         // Add border to mimic the boxes drawn in the sketch
//         border: Border.all(
//           color: borderColor,
//           width: item.isRead ? 1.0 : 2.0, // Thicker border for unread
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // --- Notification Title ---
//           Expanded(
//             child: Text(
//               item.title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold,
//                 color: item.isRead ? Colors.black54 : Colors.black87,
//               ),
//             ),
//           ),

//           // --- Time and Checkbox (Corner Elements) ---
//           Row(
//             children: [
//               // Time in the corner
//               Text(
//                 item.time,
//                 style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//               ),
//               const SizedBox(width: 8),
//               // Checkbox
//               SizedBox(
//                 width: 24, // Control the size of the checkbox area
//                 height: 24,
//                 child: Checkbox(
//                   value: item.isRead,
//                   onChanged: onCheckboxChanged,
//                   activeColor: Colors.green.shade700,
//                   checkColor: Colors.white,
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // --- Example Main Function to Run the App ---







import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; 

// --- Data Model ---
class NotificationItem {
  final String id;
  final String title;
  final Timestamp timestamp;
  // Removed isRead field as it's no longer used for local logic/UI
  // final bool isRead; 

  NotificationItem({
    required this.id,
    required this.title,
    required this.timestamp,
    // removed isRead from constructor
  });
}

// --- Notification Screen Implementation ---
class ContractorNotification extends StatefulWidget {
  const ContractorNotification({super.key});

  @override
  State<ContractorNotification> createState() => _ContractorNotificationState();
}

class _ContractorNotificationState extends State<ContractorNotification> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. Stream to fetch all notifications for the current contractor.
  Stream<QuerySnapshot> get _notificationStream {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      return Stream.empty();
    }

    // NOTE: This query requires a composite index:
    // Collection: notifications, Fields: requestedToId (ASC), timestamp (DESC)
    return _firestore
        .collection('notifications')
        .where('requestedToId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // 2. Function to remove the item (DELETE from Firestore on swipe)
  void _removeNotification(String notificationId, String title) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).delete();
      // SnackBar logic is now in Dismissible's onDismissed callback
    } catch (e) {
      // Show error snackbar for delete failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete: $e')),
      );
    }
  }

  // 3. Function to update isRead status (removed completely)
  /*
  void _markAsRead(String notificationId) async {
    // ... logic removed ...
  }
  */

  // 4. Time formatting utility
  String _formatTime(Timestamp timestamp) {
    DateTime now = DateTime.now();
    DateTime date = timestamp.toDate();
    Duration diff = now.difference(date);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser == null) {
      return const Center(child: Text('Please log in to view notifications.'));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AppBar(
            centerTitle: true,
            title: const Text(
              "Notification",
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
      backgroundColor: Colors.grey.shade50,

      // StreamBuilder fetches real-time notifications
      body: StreamBuilder<QuerySnapshot>(
        stream: _notificationStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Display specific index error if applicable
            return Center(child: Text('Error loading data: ${snapshot.error}. Make sure Firestore index is created!'));
          }

          final notifications = snapshot.data?.docs ?? [];

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                'No new notifications.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final doc = notifications[index];
              final data = doc.data() as Map<String, dynamic>;

              final item = NotificationItem(
                id: doc.id,
                title: data['notificationMsg'] ?? 'Untitled Notification', 
                timestamp: data['timestamp'] as Timestamp? ?? Timestamp.now(),
                // isRead: (data['isRead'] as bool?) ?? false, // removed
              );

              // --- Dismissible Widget for Swipe-to-Remove (Delete) ---
              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red.shade700,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                // Action when the item is dismissed (Swipe to remove)
                onDismissed: (direction) {
                  _removeNotification(item.id, item.title);
                  // Show success snackbar for delete after the item is dismissed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notification "${item.title}" deleted.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                
                // --- Notification Card ---
                child: NotificationCard(
                  item: item,
                  timeString: _formatTime(item.timestamp),
                  // onCheckboxChanged removed entirely
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// --- Individual Notification Card Widget ---
class NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final String timeString; 
  // Removed ValueChanged<bool?> onCheckboxChanged;

  const NotificationCard({
    super.key,
    required this.item,
    required this.timeString,
    // Removed onCheckboxChanged from constructor
  });

  @override
  Widget build(BuildContext context) {
    // Removed isRead logic for border and text color

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey.shade300, // Standard gray border
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- Notification Title ---
          Expanded(
            child: Text(
              item.title,
              style: const TextStyle( // Simplified style
                fontSize: 16,
                fontWeight: FontWeight.normal, 
                color: Colors.black87,
              ),
            ),
          ),

          // --- Time (Corner Element) ---
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              timeString, 
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          // Checkbox logic removed entirely
        ],
      ),
    );
  }
}