import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/remove_question.dart';
import 'package:planeje/quiz_revision/utils/register_question/register_question.dart';

class QuestionController {
  List<Question> questions = [];

  Future<bool> writeQuestion() async {
    if (questions.isNotEmpty) await SaveQuestion(QuestionDatabase(), questions: questions).writeQuestionList();

    return true;
  }

  Future<void> deleteTable() async => await RemoveQuestion(QuestionDatabase()).deleteTable();
}
