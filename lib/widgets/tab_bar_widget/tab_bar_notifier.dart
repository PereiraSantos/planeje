import 'package:flutter/material.dart';

class TabBarNotifier with ChangeNotifier {
  Notifier learnNotifier = Notifier();
  Notifier revisionNotifier = Notifier();
  Notifier annotationNotifier = Notifier();
  Notifier quizNotifier = Notifier();
  SearchNotifier searchNotifier = SearchNotifier();

  void update() => notifyListeners();
}

class SearchNotifier with ChangeNotifier {
  bool _hideSearch = false;

  bool get hideSearch => _hideSearch;

  void updateHideSearch(bool value) {
    _hideSearch = value;
    notifyListeners();
  }
}

class Notifier with ChangeNotifier {
  String? _search;

  String? get search => _search;
  void setSearch(String? value) {
    _search = value;
    update();
  }

  void update() => notifyListeners();
}
