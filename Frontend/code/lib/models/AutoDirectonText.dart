import 'package:flutter/material.dart';

class AutoDirectionText extends StatelessWidget {
  final String text;
  final TextStyle style;

  AutoDirectionText(this.text, {this.style = const TextStyle()});

  TextDirection detectTextDirection(String text) {
    // Your logic to detect text direction
    // For simplicity, let's assume if the text contains any Arabic or Hebrew characters, it's RTL
    if (text.contains(RegExp(r'[\u0600-\u06FF\u0590-\u05FF]'))) {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: detectTextDirection(text),
      style: style ??
          TextStyle(), // Apply the provided style or use a default style
    );
  }
}
