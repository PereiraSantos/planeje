import 'package:flutter/material.dart';

import '../../../entities/question.dart';

class TableQuestionController with ChangeNotifier {
  List<Question> listQuestion = [];

  void update(Question element) {
    listQuestion.add(element);
    notifyListeners();
  }

  void updateList(List<Question> element) {
    listQuestion = element;
    notifyListeners();
  }

  void updateIdQuiz(int idQuiz) {
    for (var i = 0; i < listQuestion.length; i++) {
      listQuestion[i].idQuiz = idQuiz;
    }
  }

  void updateAnwser(int index, value) {
    for (var i = 0; i < listQuestion.length; i++) {
      listQuestion[i].answer = i == index ? value : false;
    }
    notifyListeners();
  }

  bool isAnwser() {
    var result = listQuestion.where((element) => element.answer!);
    if (result.isNotEmpty) return true;
    return false;
  }
}
