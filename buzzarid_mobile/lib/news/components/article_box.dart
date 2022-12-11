import 'package:flutter/material.dart';

import 'image_network.dart';

class ArticleBox extends StatelessWidget {
  const ArticleBox(
      {super.key,
      required this.onTap,
      required this.imageUrl,
      required this.title,
      required this.author,
      required this.createdAt,
      required this.likes});

  final void Function() onTap;
  final String imageUrl;
  final String title;
  final String author;
  final String createdAt;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ImageNetwork(imageUrl: imageUrl, height: 200.0, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(author),
                  Text(createdAt),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.thumb_up),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text('$likes')
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
