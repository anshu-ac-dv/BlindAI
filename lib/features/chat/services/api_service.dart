import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  GenerativeModel? _model;

  void _initModel() {
    if (_model != null) return;
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey != null && apiKey.isNotEmpty) {
      _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );
    }
  }

  Future<String> getResponse(String prompt, {Uint8List? imageBytes, String? mimeType}) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      return '❌ Error: Gemini API Key not found. Please add GEMINI_API_KEY to your .env file.';
    }

    _initModel();
    if (_model == null) return 'Error: Failed to initialize Gemini model.';

    try {
      final content = [
        Content.multi([
          TextPart(prompt),
          if (imageBytes != null && mimeType != null)
            DataPart(mimeType, imageBytes),
        ])
      ];
      
      final response = await _model!.generateContent(content);
      return response.text ?? 'No response';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
