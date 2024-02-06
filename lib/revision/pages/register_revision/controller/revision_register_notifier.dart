import 'package:flutter/material.dart';

class ReviserRegisterNotifier with ChangeNotifier {
  bool? _reviewed;

  bool? get reviewed => _reviewed;

  void update(bool value) {
    _reviewed = value;
    notifyListeners();
  }
}
