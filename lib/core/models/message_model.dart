class Message {
  final String text;
  final bool isUser;
  final DateTime time;
  final String? imagePath;

  Message({
    required this.text,
    required this.isUser,
    required this.time,
    this.imagePath,
  });
}
