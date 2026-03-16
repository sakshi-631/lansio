



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lansio/services/chat_service.dart';

// class CommonChatPage extends StatefulWidget {
//   final String chatId;
//   final String receiverId;
//   final String receiverName;
//   final String receiverType;
//   final String senderId;
//   final String senderType;

//   const CommonChatPage({
//     super.key,
//     required this.chatId,
//     required this.receiverId,
//     required this.receiverName,
//     required this.receiverType,
//     required this.senderId,
//     required this.senderType,
//   });

//   @override
//   State<CommonChatPage> createState() => _CommonChatPageState();
// }

// class _CommonChatPageState extends State<CommonChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();

//   @override
//   void initState() {
//     super.initState();
//     _ensureMessagesSubcollectionExists();
//   }

//   /// ✅ Create messages subcollection if it doesn’t exist
//   Future<void> _ensureMessagesSubcollectionExists() async {
//     final messagesRef = FirebaseFirestore.instance
//         .collection('chats')
//         .doc(widget.chatId)
//         .collection('messages');

//     final snapshot = await messagesRef.limit(1).get();
//     if (snapshot.docs.isEmpty) {
//       await messagesRef.add({
//         'senderId': widget.senderId,
//         'senderType': widget.senderType,
//         'receiverId': widget.receiverId,
//         'receiverType': widget.receiverType,
//         'message': '👋 Chat started!',
//         'type': 'system',
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     }
//   }

//   /// ✅ Send text message only
//   Future<void> _sendMessage() async {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;

//     await _chatService.sendMessage(
//       chatId: widget.chatId,
//       message: text,
//       senderId: widget.senderId,
//       type: 'text', // ✅ consistent message type
//     );

//     _messageController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentUserId = FirebaseAuth.instance.currentUser!.uid;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text(widget.receiverName),
//       ),
//       body: Column(
//         children: [
//           /// ✅ Chat message list
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chats')
//                   .doc(widget.chatId)
//                   .collection('messages')
//                   .orderBy('timestamp', descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final messages = snapshot.data!.docs;

//                 if (messages.isEmpty) {
//                   return const Center(child: Text("No messages yet."));
//                 }

//                 return ListView.builder(
//                   padding: const EdgeInsets.all(8),
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final data =
//                         messages[index].data() as Map<String, dynamic>;
//                     final text = data['message'] ?? '';
//                     final isMe = data['senderId'] == currentUserId;

//                     return Align(
//                       alignment: isMe
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 4),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: isMe
//                               ? Colors.teal.withOpacity(0.85)
//                               : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           text,
//                           style: TextStyle(
//                             color: isMe ? Colors.white : Colors.black87,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),

//           /// ✅ Message input area
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: InputDecoration(
//                         hintText: "Type a message...",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   IconButton(
//                     icon: const Icon(Icons.send, color: Colors.teal),
//                     onPressed: _sendMessage,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }










import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lansio/services/chat_service.dart';

class CommonChatPage extends StatefulWidget {
  final String chatId;
  final String receiverId;
  final String receiverName;
  final String receiverType;
  final String senderId;
  final String senderType;

  const CommonChatPage({
    super.key,
    required this.chatId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverType,
    required this.senderId,
    required this.senderType,
  });

  @override
  State<CommonChatPage> createState() => _CommonChatPageState();
}

class _CommonChatPageState extends State<CommonChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _ensureMessagesSubcollectionExists();
    _fetchReceiverProfile(); // ✅ Fetch profile pic at start
  }

  /// ✅ Fetch receiver’s profile image based on their type (user/worker/contractor)
  Future<void> _fetchReceiverProfile() async {
    try {
      final collectionName = widget.receiverType == 'user'
          ? 'users'
          : widget.receiverType == 'worker'
              ? 'workers'
              : 'contractors';

      final doc = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(widget.receiverId)
          .get();

      if (doc.exists && doc.data()!.containsKey('profileImage')) {
        setState(() {
          profileImageUrl = doc['profileImage'];
        });
      }
    } catch (e) {
      debugPrint("⚠️ Error fetching profile: $e");
    }
  }

  /// ✅ Ensure messages collection exists
  Future<void> _ensureMessagesSubcollectionExists() async {
    final messagesRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages');

    final snapshot = await messagesRef.limit(1).get();
    if (snapshot.docs.isEmpty) {
      await messagesRef.add({
        'senderId': widget.senderId,
        'senderType': widget.senderType,
        'receiverId': widget.receiverId,
        'receiverType': widget.receiverType,
        'message': '👋 Chat started!',
        'type': 'system',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  /// ✅ Send text message
  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    await _chatService.sendMessage(
      chatId: widget.chatId,
      message: text,
      senderId: widget.senderId,
      type: 'text',
    );

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 90, 161, 75),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: profileImageUrl != null
                  ? NetworkImage(profileImageUrl!)
                  : const AssetImage('assets/default_user.png')
                      as ImageProvider, // fallback image
            ),
            const SizedBox(width: 10),
            Text(
              widget.receiverName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          /// ✅ Chat message list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                if (messages.isEmpty) {
                  return const Center(child: Text("No messages yet."));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data =
                        messages[index].data() as Map<String, dynamic>;
                    final text = data['message'] ?? '';
                    final isMe = data['senderId'] == currentUserId;

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.teal.withOpacity(0.85)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          text,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          /// ✅ Message input area
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.teal),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

