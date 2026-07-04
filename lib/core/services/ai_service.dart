import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  // TODO: Replace with your actual Gemini API Key from Google AI Studio
  static const String _apiKey = 'YOUR_GEMINI_API_KEY';
  
  final GenerativeModel _model;

  AIService() : _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: _apiKey,
  );

  Future<String> describeScene(File imageFile) async {
    return _generateFromImage(
      imageFile, 
      "Describe this image in detail for a visually impaired person. Focus on objects, people, and potential obstacles."
    );
  }

  Future<String> readText(File imageFile) async {
    return _generateFromImage(
      imageFile, 
      "Extract and read all the text from this image. If it's a document, maintain the structure. If it's a sign, just read the text clearly."
    );
  }

  Future<String> identifyColor(File imageFile) async {
    return _generateFromImage(
      imageFile, 
      "Identify the dominant colors in this image and describe them clearly. For example, 'The object is a bright navy blue'."
    );
  }

  Future<String> _generateFromImage(File imageFile, String promptText) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      final prompt = TextPart(promptText);
      final imagePart = DataPart('image/jpeg', imageBytes);

      final response = await _model.generateContent([
        Content.multi([prompt, imagePart])
      ]);

      return response.text ?? "I'm sorry, I couldn't analyze the image.";
    } catch (e) {
      return "Error analyzing image: $e";
    }
  }
}
