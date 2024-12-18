import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    super.key,
    required this.label,
    this.fontSize = 16,
    this.color = Colors.black54,
    this.maxLines = 1,
    this.fontWeight = FontWeight.normal,
    this.padding,
  });

  final String label;
  final double? fontSize;
  final Color color;
  final int? maxLines;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(5),
      child: Text(
        label,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
