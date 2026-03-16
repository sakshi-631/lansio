import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lansio/services/gemini_service.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;

  void sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "text": userMessage});
      _controller.clear();
      isLoading = true;
    });

    // 🧩 Detect if user asked for image
    bool wantsImage =
        userMessage.toLowerCase().contains("image") ||
        userMessage.toLowerCase().contains("picture") ||
        userMessage.toLowerCase().contains("generate");

    if (wantsImage) {
      final imageBytes = await _geminiService.generateImage(userMessage);
      if (imageBytes != null) {
        setState(() {
          messages.add({"role": "bot", "image": imageBytes});
        });
      } else {
        setState(() {
          messages.add({"role": "bot", "text": "Failed to generate image."});
        });
      }
    } else {
      final aiReply = await _geminiService.generateText(userMessage);
      setState(() {
        messages.add({"role": "bot", "text": aiReply});
      });
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gemini AI Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg['role'] == 'user';

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: msg.containsKey('image')
                        ? Image.memory(
                            msg['image'],
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          )
                        : Text(
                            msg['text'] ?? '',
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Ask or generate image...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}










