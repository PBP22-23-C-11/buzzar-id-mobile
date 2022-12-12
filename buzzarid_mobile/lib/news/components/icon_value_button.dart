import 'package:flutter/material.dart';

class IconValueButton extends StatelessWidget {
  const IconValueButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.value,
      required this.onPressed});

  final Color color;
  final Icon icon;
  final String value;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: icon,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Text(value)
        ],
      ),
    );
  }
}
