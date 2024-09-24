import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    super.key,
    required this.revisionEntity,
    this.fontSize = 16,
    this.color = Colors.black54,
    this.maxLines = 1,
    this.fontWeight = FontWeight.normal,
    this.padding,
    this.textAlign = TextAlign.left,
  });

  final String revisionEntity;
  final double? fontSize;
  final Color color;
  final int? maxLines;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(5),
      child: Text(
        revisionEntity,
        maxLines: maxLines,
        textAlign: textAlign,
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
