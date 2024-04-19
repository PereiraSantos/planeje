import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckBoxCustom extends StatelessWidget {
  CheckBoxCustom({super.key, required this.isChecked, required this.onClick});
  bool isChecked;
  final Function(bool?) onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.grey,
        value: isChecked,
        onChanged: (bool? value) => onClick(value),
      ),
    );
  }
}
