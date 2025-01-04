import 'package:flutter/material.dart';

class MessageUser {
  static void message(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 100, left: 10, right: 10),
    ));
  }
}
