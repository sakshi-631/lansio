
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Create or get chat ID between two users (auto-handles duplicates)
  Future<String> getOrCreateChatId({
    required String senderId,
    required String receiverId,
    required String senderType,
    required String receiverType,
  }) async {
    final chatsRef = _firestore.collection('chats');

    // Check if chat already exists between these two
    final existingChat = await chatsRef
        .where('participants', arrayContains: senderId)
        .get();

    for (var doc in existingChat.docs) {
      final participants = List<String>.from(doc['participants']);
      if (participants.contains(receiverId)) {
        return doc.id; // Existing chat found
      }
    }

    // Create new chat if not found
    final newChat = await chatsRef.add({
      'participants': [senderId, receiverId],
      'senderType': senderType,
      'receiverType': receiverType,
      'lastMessage': '',
      'timestamp': FieldValue.serverTimestamp(),
    });

    return newChat.id;
  }

  /// ✅ Send message in a chat
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String message, required String type,
  }) async {
    final messagesRef =
        _firestore.collection('chats').doc(chatId).collection('messages');

    await messagesRef.add({
      'senderId': senderId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update chat with last message
    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// ✅ Stream all messages of a particular chat
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  /// ✅ Stream all chats of current user
  Stream<QuerySnapshot> getUserChats(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  /// ✅ Delete a chat (optional)
  Future<void> deleteChat(String chatId) async {
    final messages =
        await _firestore.collection('chats').doc(chatId).collection('messages').get();

    for (var msg in messages.docs) {
      await msg.reference.delete();
    }

    await _firestore.collection('chats').doc(chatId).delete();
  }
}
