import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey =
      "AIzaSyBAgyAu3ogh9HfeKwr_Jaz6FL1FUAxSwvY"; // Replace with your Gemini API key

  // ✅ Text generation model
  final String textUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  // ✅ Image generation model
  final String imageUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-image:generateContent";

  /// --- TEXT GENERATION ---
  Future<String> generateText(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(textUrl),
        headers: {'Content-Type': 'application/json', 'x-goog-api-key': apiKey},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        return reply ?? "No response from AI.";
      } else {
        return "API Error ${response.statusCode}: ${response.body}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  /// --- IMAGE GENERATION ---
  Future<Uint8List?> generateImage(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(imageUrl),
        headers: {'Content-Type': 'application/json', 'x-goog-api-key': apiKey},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final imagePart = data['candidates']?[0]?['content']?['parts']?[0];
        if (imagePart?['inline_data']?['data'] != null) {
          final base64Image = imagePart['inline_data']['data'];
          return base64Decode(base64Image);
        } else {
          return null;
        }
      } else {
        print("Image API Error ${response.statusCode}: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Image generation error: $e");
      return null;
    }
  }
}
