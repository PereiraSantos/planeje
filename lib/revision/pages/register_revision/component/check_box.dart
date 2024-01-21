import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckBoxComponent extends StatefulWidget {
  CheckBoxComponent({
    super.key,
    required this.child,
    required this.onClick,
    this.isChecked = false,
  });

  final Widget child;
  final Function(bool) onClick;
  bool? isChecked;

  @override
  State<CheckBoxComponent> createState() => _CheckBoxComponentState();
}

class _CheckBoxComponentState extends State<CheckBoxComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.green,
          value: widget.isChecked ?? false,
          onChanged: (bool? value) {
            setState(() {
              widget.isChecked = value!;
            });

            widget.onClick(value!);
          },
        ),
        widget.child
      ],
    );
  }
}
