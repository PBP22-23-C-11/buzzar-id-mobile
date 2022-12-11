import 'package:flutter/material.dart';

class IconValueButton extends StatelessWidget {
  const IconValueButton(
      {super.key,
      required this.icon,
      required this.value,
      required this.onPressed});

  final Icon icon;
  final String value;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
