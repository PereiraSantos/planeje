import 'package:planeje/quiz_revision/entities/question.dart';

class ListQuestionController {
  bool isShowAnswer = false;
  int index = -1;

  set showAnswer(bool value) => isShowAnswer = value;

  bool getCheck(List<Question> list, int index) => list[index].uniqueAnswer ?? false;

  bool isAnswer(List<Question> list, bool success) {
    if (index != -1) {
      return (isShowAnswer &&
          (list[index].uniqueAnswer ?? false) &&
          (list[index].answer ?? false) == success);
    }
    return isShowAnswer;
  }

  void updateAnswer(int i, value, List<Question> list) {
    showAnswer = false;
    index = i;
    list.map((e) => e.uniqueAnswer = false).toList();
    list[i].uniqueAnswer = value;
  }
}
