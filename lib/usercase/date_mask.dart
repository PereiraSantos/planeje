import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class DateMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var date = newValue.text;

    if (date.length > 10) return oldValue;

    date = date.replaceAll(RegExp(r'\D'), '');

    var formated = '';

    for (var i = 0; i < date.characters.length; i++) {
      if ([2, 4].contains(i)) {
        formated += '/';
      }
      formated += date[i];
    }

    return newValue.copyWith(
      text: formated,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formated.length),
      ),
    );
  }
}
