import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.label,
    this.color = Colors.black45,
  });

  final Function onTap;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: color, width: 0.5),
              left: BorderSide(color: color, width: 0.5),
              right: BorderSide(color: color, width: 0.5),
              bottom: BorderSide(color: color, width: 0.5),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(4)),
        child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.black45)),
      ),
    );
  }
}
