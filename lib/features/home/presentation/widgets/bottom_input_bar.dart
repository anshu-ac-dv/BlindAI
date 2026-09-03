import 'package:flutter/material.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isDark ? const Color(0xFF2C2C38) : const Color(0xFFEAECEF),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.add_photo_alternate_outlined,
                color: primaryColor,
                size: 22,
              ),
              onPressed: widget.onGalleryPressed,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => _handleSend(),
                decoration: InputDecoration(
                  hintText: 'Enter a prompt here...',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white38 : const Color(0xFF8F93A0),
                    fontSize: 14,
                  ),
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                child: Icon(
                  _isTyping ? Icons.send_rounded : Icons.mic_none_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
