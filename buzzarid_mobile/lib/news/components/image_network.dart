import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.fit});

  final String imageUrl;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl, errorBuilder:
        (BuildContext context, Object exception, StackTrace? stackTrace) {
      return const Text('Couldn\'t Load Image');
    }, width: double.infinity, height: height, fit: fit);
  }
}
