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
        shape: const CircleBorder(),
        side: WidgetStateBorderSide.resolveWith(
          (states) => const BorderSide(width: 1.0, color: Colors.grey),
        ),
        onChanged: (bool? value) => onClick(value),
      ),
    );
  }
}
