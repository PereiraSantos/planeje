import 'package:flutter/material.dart';
import 'package:planeje/widgets/button_custon.dart';

// ignore: must_be_immutable
class HomeAppBarWidget extends StatelessWidget {
  HomeAppBarWidget({super.key, required this.onClick, this.color});

  final Function() onClick;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: ButtonCuston(
        color: color ?? Colors.black12,
        width: 30,
        child: const Icon(
          Icons.home,
          color: Colors.black54,
          size: 20,
        ),
      ),
    );
  }
}
