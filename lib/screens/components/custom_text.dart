import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color textColor;
  final TextAlign textAlign;
  const CustomText(
      {super.key,
      required this.text,
      required this.size,
      required this.textColor,
      required this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: textColor,
      ),
    );
  }
}
