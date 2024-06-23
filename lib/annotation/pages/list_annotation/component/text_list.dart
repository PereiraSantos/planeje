import 'package:flutter/material.dart';
import 'package:planeje/utils/string_extension.dart';

class TextList extends StatelessWidget {
  final String annotationEntity;
  final int flex;
  final double top;
  final double size;
  final double? left = 10;
  final double bottom;

  const TextList(this.annotationEntity,
      {super.key, this.flex = 5, this.top = 10, this.size = 0.05, this.bottom = 0});

  factory TextList.date(String annotationEntity) =>
      TextList(annotationEntity, flex: 0, top: 15.0, size: 0.030, bottom: 5);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.only(left: left!, top: top, bottom: bottom),
        child: Text(
          annotationEntity.capitalize(),
          maxLines: null,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * size,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
