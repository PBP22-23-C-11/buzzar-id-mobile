import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  const CommentBox(
      {super.key,
      required this.name,
      required this.createdAt,
      required this.body});

  final String name;
  final String createdAt;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: Colors.grey,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Text(createdAt),
              const SizedBox(height: 8.0),
              Text(body),
            ],
          ),
        ),
      ],
    );
  }
}
