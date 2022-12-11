import 'package:buzzarid_mobile/news/components/icon_value_button.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  const CommentBox(
      {super.key,
      required this.name,
      required this.createdAt,
      required this.body,
      required this.showDelete,
      this.onDelete});

  final String name;
  final String createdAt;
  final String body;
  final bool showDelete;
  final void Function()? onDelete;

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
              (showDelete)
                  ? Row(children: [
                      IconValueButton(
                          color: Colors.red,
                          icon: const Icon(Icons.delete),
                          value: 'Delete',
                          onPressed: onDelete),
                    ])
                  : Container(),
              const SizedBox(height: 8.0),
              Text(body),
            ],
          ),
        ),
      ],
    );
  }
}
