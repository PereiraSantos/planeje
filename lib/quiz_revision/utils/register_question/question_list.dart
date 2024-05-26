import 'package:planeje/quiz_revision/entities/question.dart';

class QuestionList {
  bool add;
  bool update;
  bool delete;
  Question? question;
  QuestionList({this.add = false, this.update = false, this.delete = false, this.question});
}
