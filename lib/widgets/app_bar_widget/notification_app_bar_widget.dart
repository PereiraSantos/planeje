import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationAppBarWidget extends StatelessWidget {
  NotificationAppBarWidget({super.key, this.quantity = 0});

  int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 05.0),
      child: SizedBox(
        width: 35,
        child: IconButton(
          onPressed: null,
          icon: Badge(
            label: Text("$quantity"),
            isLabelVisible: quantity > 0 ? true : false,
            child: const Icon(
              Icons.notifications,
              color: Colors.black54,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
