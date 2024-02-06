import 'package:flutter/material.dart';

class ButtonList extends StatelessWidget {
  const ButtonList(this.onClick, {super.key, this.color = Colors.blue, this.icon = Icons.edit});

  factory ButtonList.delete(Function onClick) => ButtonList(onClick, color: Colors.red, icon: Icons.delete);

  final MaterialColor color;
  final Function onClick;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: IconButton(
        onPressed: () => onClick(),
        icon: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
