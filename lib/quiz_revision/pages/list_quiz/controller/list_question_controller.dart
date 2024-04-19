import 'package:planeje/quiz_revision/entities/question.dart';

import '../../../datasource/database/question_database.dart';
import '../../../usercase/question_usercase/question_usercase.dart';

class ListQuestionController {
  QuestionUsercase questionUsercase = QuestionUsercase(QuestionDatabase());
  bool answer = false;
  int id = -1;
  bool showMessageYes = false;
  bool showMessageNo = false;

  void findValueAnswer(List<Question> list) {
    var result = list.where((element) => element.answer == true).toList();
    answer = result[0].answer!;
    id = result[0].id!;

    for (var i = 0; i < list.length; i++) {
      list[i].answer = false;
    }
  }

  void findAnswer(List<Question> list) {
    showMessageNo = false;
    showMessageYes = false;

    var result = list.where((element) => element.answer!).toList();
    if (result.isEmpty) return;
    if (result[0].id! == id) {
      showMessageYes = true;
    } else {
      showMessageNo = true;
    }
  }

  Future<List<Question>?> listQuestionByIdQuiz(int idQuiz) async {
    return await questionUsercase.getQuestionByIdQuiz(idQuiz);
  }

  bool getCheck(List<Question> list, int index) {
    return list[index].answer ?? false;
  }

  void updateAwser(int index, value, List<Question> list) {
    for (var i = 0; i < list.length; i++) {
      list[i].answer = i == index ? value : false;
    }
  }
}
