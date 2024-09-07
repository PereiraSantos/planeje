import 'package:flutter/material.dart';
import 'package:planeje/widgets/button_custon.dart';

// ignore: must_be_immutable
class AppBarButtonWidget extends StatelessWidget {
  AppBarButtonWidget({
    super.key,
    required this.onClick,
    required this.title,
    this.color,
    this.value,
  });

  final Function() onClick;
  final String title;
  Color? color;
  double? value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: ButtonCuston(
        color: color ?? Colors.black12,
        width: MediaQuery.of(context).size.width * (value ?? 0.2).toDouble(),
        margin: const EdgeInsets.only(left: 05),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(137, 10, 5, 5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
