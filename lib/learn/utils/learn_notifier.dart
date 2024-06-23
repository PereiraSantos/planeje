import 'package:flutter/material.dart';

class LearnNotifier with ChangeNotifier {
  void updateBody() => notifyListeners();
}
