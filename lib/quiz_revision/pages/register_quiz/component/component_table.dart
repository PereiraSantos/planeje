import 'package:flutter/material.dart';

mixin ComponentTable {
  Widget row(String value) {
    return Container(
      padding: const EdgeInsets.only(left: 02, right: 02),
      child: Text(value, style: const TextStyle(fontSize: 12)),
    );
  }

  TableRow getRow({
    required String description,
    String? answer,
    Color? color,
    Widget? child,
    Widget? icon,
  }) {
    return TableRow(
      decoration: BoxDecoration(color: color),
      children: <Widget>[
        row(description),
        if (answer != null) ...[row(answer)],
        if (child != null) ...[child],
        icon!,
      ],
    );
  }
}
