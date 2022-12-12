import 'package:flutter/material.dart';

class TextTitleContent extends StatelessWidget {
  const TextTitleContent(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: '$title: ',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          TextSpan(
            text: content,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
