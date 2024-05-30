import 'package:flutter/material.dart';

class MessageUser {
  static void message(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
