import 'dart:math';
import 'package:flutter/material.dart';
import 'package:planeje/suggestion/entities/suggestion.dart';

class SuggestionNotifier with ChangeNotifier {
  List<Suggestion> suggestions = [];
  bool showBotton = false;
  bool showBottonReset = false;
  Suggestion? sortition;

  setSelectSuggestion(int index, bool select) {
    suggestions[index].select = select;
    var result = suggestions.where((e) => e.select).toList();
    showBotton = result.isNotEmpty;
    update();
  }

  setList(List<Suggestion> value) async {
    suggestions = value;
    showBotton = false;
    var result = suggestions.where((e) => e.sortition ?? false).toList();
    showBottonReset = result.isNotEmpty;

    Future.delayed(const Duration(milliseconds: 10), () => update());
  }

  sortitionValue() {
    List<Suggestion> result = suggestions.where((e) => e.select).toList();

    Suggestion element = result[Random().nextInt(result.length)];

    int index = suggestions.indexWhere((e) => e.id == element.id);

    for (var i = 0; i < suggestions.length; i++) {
      suggestions[i].sortition = i == index;
    }

    sortition = suggestions[index];

    update();
  }

  resetSortition() {
    showBottonReset = false;
    update();
  }

  void update() => notifyListeners();
}
