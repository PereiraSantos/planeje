import 'package:flutter/material.dart';
import 'package:planeje/utils/string_extension.dart';

class TextList extends StatelessWidget {
  final String annotationEntity;
  final int flex;
  final double top;
  final double fontSize;
  final double? left = 10;
  final double bottom;
  final Color? color;
  final FontWeight? fontWeight;

  const TextList(
    this.annotationEntity, {
    super.key,
    this.flex = 5,
    this.top = 10,
    this.fontSize = 14,
    this.bottom = 0,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.only(left: left!, top: top, bottom: bottom),
        child: Text(
          annotationEntity.capitalize(),
          maxLines: 2,
          style: TextStyle(
            fontSize: fontSize,
            color: color ?? Colors.black54,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
