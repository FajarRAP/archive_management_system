import 'package:flutter/material.dart';

class TextBadge extends StatelessWidget {
  const TextBadge({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: (color as MaterialColor).shade100,
      ),
      padding: const EdgeInsets.all(6),
      width: 100,
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}
