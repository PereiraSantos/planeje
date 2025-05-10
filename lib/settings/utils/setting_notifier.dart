import 'package:flutter/material.dart';

enum Status { start, loading, concluded, erro }

class SettingNotifier with ChangeNotifier {
  Status status = Status.start;

  init() {
    status = Status.start;
  }

  concluded() {
    status = Status.concluded;
    notifyListeners();
  }

  loading() {
    status = Status.loading;
    notifyListeners();
  }

  erro() {
    status = Status.erro;
    notifyListeners();
  }
}
