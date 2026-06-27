import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/custom_snack_bar.dart';

class BottomInputBar extends StatefulWidget {
  final Function(String) onSendMessage;
  final VoidCallback onVoicePressed;
  final VoidCallback onGalleryPressed;

  const BottomInputBar({
    super.key,
    required this.onSendMessage,
    required this.onVoicePressed,
    required this.onGalleryPressed,
  });

  @override
  State<BottomInputBar> createState() => _BottomInputBarState();
}

class _BottomInputBarState extends State<BottomInputBar> {
  final TextEditingController _messageController = TextEditingController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        _isTyping = _messageController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_messageController.text.trim().isNotEmpty) {
      widget.onSendMessage(_messageController.text.trim());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E26) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.add_photo_alternate_outlined,
                  color: theme.colorScheme.primary),
              onPressed: widget.onGalleryPressed,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => _handleSend(),
                decoration: InputDecoration(
                  hintText: 'Enter a prompt here',
                  hintStyle: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black38),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ),
            GestureDetector(
              onTap: _isTyping ? _handleSend : widget.onVoicePressed,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF673AB7), Color(0xFFFF4081)],
                  ),
                ),
                child: Icon(
                  _isTyping ? Icons.send_rounded : Icons.mic_none_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
