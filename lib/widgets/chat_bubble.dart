import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  const ChatBubble({Key? key, required this.message, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}