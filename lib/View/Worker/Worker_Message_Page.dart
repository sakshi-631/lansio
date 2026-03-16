
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lansio/View/common_chat_page.dart';
import 'package:lansio/services/chat_service.dart';

class WorkerMessagePage extends StatelessWidget {
  const WorkerMessagePage({super.key});

  ImageProvider _getImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return NetworkImage(imageUrl);
    }
    return const AssetImage("assets/userprofile.jpeg");
  }

  Future<Map<String, dynamic>?> _fetchUserData(String receiverType, String id) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<String> collections = ["users", "workers", "contractors"];

    for (var collection in collections) {
      try {
        final doc = await firestore.collection(collection).doc(id).get();
        if (doc.exists) return doc.data();
      } catch (_) {}
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final chatService = ChatService();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F6F3),
     
      body: StreamBuilder<QuerySnapshot>(
        stream: chatService.getUserChats(currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.green));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No chats yet"));
          }

          final chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chatData = chats[index].data() as Map<String, dynamic>;
              final participants = (chatData['participants'] ?? []).cast<String>();
              if (participants.isEmpty) return const SizedBox();
              final otherId = participants.firstWhere((id) => id != currentUser.uid, orElse: () => '');
              final receiverType = chatData['receiverType'] ?? 'user';
              final lastMessage = chatData['lastMessage'] ?? '';

              return FutureBuilder<Map<String, dynamic>?>(
                future: _fetchUserData(receiverType, otherId),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      leading: CircleAvatar(child: Icon(Icons.person)),
                      title: Text("Loading..."),
                    );
                  }

                  final userData = userSnapshot.data;
                  if (userData == null) {
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: const Text("Unknown User"),
                      subtitle: Text(lastMessage),
                    );
                  }

                  final name = userData['name'] ?? userData['fullName'] ?? userData['username'] ?? 'Unnamed';
                  final profilePic = userData['profileImage'] ?? userData['profilePic'] ?? userData['profileUrl'] ?? '';

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: _getImage(profilePic),
                        backgroundColor: Colors.green.shade100,
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      subtitle: Text(
                        lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      onTap: () {
                        if (otherId.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CommonChatPage(
                                chatId: chats[index].id,
                                receiverId: otherId,
                                receiverName: name,
                                receiverType: receiverType,
                                senderId: currentUser.uid,
                                senderType: "worker",
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Unable to open chat. Invalid user.")),
                          );
                        }
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
