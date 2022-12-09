import 'package:flutter/material.dart';

class TryImage extends StatelessWidget {
  const TryImage(
      {super.key,
      required this.url,
      required this.width,
      required this.height,
      required this.fit});

  final String url;
  final double width;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    try {
      print(url);
      return Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return const Text('error');
        },
      );
    } catch (e) {
      return const Text('Couldn\'t Load Image');
    }
  }
}
