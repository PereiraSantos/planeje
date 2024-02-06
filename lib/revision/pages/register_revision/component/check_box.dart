import 'package:flutter/material.dart';

class CheckBoxComponent extends StatelessWidget {
  const CheckBoxComponent({
    super.key,
    required this.label,
    required this.onClick,
    this.isChecked = false,
  });

  final String label;
  final Function(bool) onClick;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.green,
              value: isChecked,
              onChanged: (bool? value) => onClick(value!)),
          Text(
            label,
            style: const TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 134, 134, 134),
            ),
          ),
        ],
      ),
    );
  }
}
