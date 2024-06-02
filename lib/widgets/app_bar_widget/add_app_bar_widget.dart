import 'package:flutter/material.dart';

class AddAppBarWidget extends StatelessWidget {
  const AddAppBarWidget({super.key, required this.onClick});

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width: 30,
        child: IconButton(
          onPressed: () async => await onClick(),
          icon: const Icon(
            Icons.add,
            color: Colors.black54,
            size: 20,
          ),
        ),
      ),
    );
  }
}
