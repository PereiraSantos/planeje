import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingAppBarWidget extends StatelessWidget {
  const SettingAppBarWidget({super.key, required this.onClick});

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, bottom: 5),
      child: SizedBox(
        width: 35,
        child: IconButton(
          onPressed: onClick,
          icon: const Icon(
            Icons.settings,
            color: Colors.black54,
            size: 24,
          ),
        ),
      ),
    );
  }
}
