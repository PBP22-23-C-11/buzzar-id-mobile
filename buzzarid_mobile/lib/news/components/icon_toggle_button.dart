import 'package:flutter/material.dart';

class IconToggleButton extends StatelessWidget {
  const IconToggleButton({
    super.key,
    required this.isElevated,
    required this.elevatedColor,
    required this.icon,
    required this.onPressed,
  });

  final bool isElevated;
  final Color elevatedColor;
  final Icon icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isElevated ? elevatedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
