import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  late final GenerativeModel _model;

  ApiService() {
    // Load API Key from .env file or environment variables
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(
        'You are a helpful assistant for the blind. Be descriptive and concise.'
      ),
    );
  }

  Future<String> sendMessage(String text, {String? imagePath, List<Content>? history}) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      return '❌ Error: Gemini API Key not found. Please add GEMINI_API_KEY to your .env file.';
    }

    try {
      final List<Part> parts = [TextPart(text)];
      
      if (imagePath != null) {
        final bytes = await File(imagePath).readAsBytes();
        parts.add(DataPart('image/jpeg', bytes));
      }

      final chat = _model.startChat(history: history);
      final response = await chat.sendMessage(Content('user', parts));
      
      return response.text ?? 'AI returned an empty response.';
    } catch (e) {
      return '❌ AI Error: $e';
    }
  }
}
