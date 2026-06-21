import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/models/message_model.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/screens/login_screen.dart';
import '../services/api_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();
  
  XFile? _selectedImage;
  bool _isLoading = false;

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutQuart,
        );
      }
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void _onSend() async {
    final text = _controller.text.trim();
    if ((text.isEmpty && _selectedImage == null) || _isLoading) return;

    final currentImage = _selectedImage;
    setState(() {
      _messages.insert(0, Message(
        text: text.isEmpty ? "Describe this image" : text,
        isUser: true,
        time: DateTime.now(),
        imagePath: currentImage?.path,
      ));
      _isLoading = true;
      _selectedImage = null;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      String response;
      if (currentImage != null) {
        final bytes = await currentImage.readAsBytes();
        response = await _apiService.getResponse(
          text.isEmpty ? "What is in this image? Describe it for a blind person." : text,
          imageBytes: bytes,
          mimeType: 'image/jpeg',
        );
      } else {
        response = await _apiService.getResponse(text);
      }

      if (mounted) {
        setState(() {
          _messages.insert(0, Message(
            text: response,
            isUser: false,
            time: DateTime.now(),
          ));
          _isLoading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.insert(0, Message(
            text: "Error: $e",
            isUser: false,
            time: DateTime.now(),
          ));
          _isLoading = false;
        });
        _scrollToBottom();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.secondary],
            ),
          ),
        ),
        title: const Text(
          'Blind AI',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: () async {
              final navigator = Navigator.of(context);
              await _authService.signOut();
              if (!mounted) return;
              navigator.pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const LoginScreen(),
                  transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState(colorScheme)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _MessageBubble(
                        message: _messages[index],
                      );
                    },
                  ),
          ),
          if (_selectedImage != null) _buildImagePreview(),
          _buildInputArea(colorScheme),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(_selectedImage!.path),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () => setState(() => _selectedImage = null),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    ).animate().scale();
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt_rounded, size: 100, color: colorScheme.primary.withAlpha(40))
              .animate(onPlay: (c) => c.repeat())
              .shimmer(duration: 2.seconds)
              .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds, curve: Curves.easeInOut),
          const SizedBox(height: 24),
          Text(
            'Take a photo to see the world',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary.withAlpha(150),
            ),
          ).animate().fadeIn(duration: 800.ms),
        ],
      ),
    );
  }

  Widget _buildInputArea(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.camera_alt_rounded, color: colorScheme.primary),
            onPressed: _pickImage,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(25)),
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Ask about something...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _onSend(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _onSend,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [colorScheme.primary, colorScheme.secondary]),
                shape: BoxShape.circle,
              ),
              child: _isLoading 
                ? const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)))
                : const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;
  
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (message.imagePath != null)
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(File(message.imagePath!), width: 200, height: 200, fit: BoxFit.cover),
              ),
            ).animate().fadeIn().scale(),
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              gradient: isUser 
                  ? LinearGradient(colors: [colorScheme.primary, colorScheme.primary.withAlpha(200)])
                  : LinearGradient(colors: [Colors.white, Colors.grey.shade50]),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isUser ? 20 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 20),
              ),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 5)],
            ),
            child: Text(
              message.text,
              style: TextStyle(color: isUser ? Colors.white : Colors.black87, fontSize: 16),
            ),
          ),
        ],
      ).animate().fadeIn().slideX(begin: isUser ? 0.1 : -0.1),
    );
  }
}
