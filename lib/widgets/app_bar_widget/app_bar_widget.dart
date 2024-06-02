import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatelessWidget {
  AppBarWidget({super.key, required this.actions, required this.child});
  List<Widget> actions;
  List<Widget> child;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xffffffff),
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.start, children: child),
      actions: actions,
    );
  }
}
