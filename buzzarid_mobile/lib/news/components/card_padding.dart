import 'package:flutter/material.dart';

class CardPadding extends StatelessWidget {
  const CardPadding({super.key, required this.padding, required this.child});

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
