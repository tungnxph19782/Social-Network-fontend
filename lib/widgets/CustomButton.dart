import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressd;
  final Color color;
  final Color textColor;
  const Custombutton({
    super.key,
    required this.text,
    required this.onPressd,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressd,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );
  }
}
