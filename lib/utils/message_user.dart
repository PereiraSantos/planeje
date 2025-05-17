import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class MessageUser {
  static Future<void> message(BuildContext context, String message, {String? title}) async {
    await Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: Colors.green,
    ).show(context);
  }
}
