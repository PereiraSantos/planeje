import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/register_quiz.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/remove_quiz.dart';

class QuizController {
  List<Quiz> quizs = [];

  Future<bool> writeQuiz() async {
    if (quizs.isNotEmpty) await SaveQuiz(QuizDatabase(), quizs: quizs).writeQuizList();

    return true;
  }

  Future<void> deteleTable() async => await DeleteQuiz(QuizDatabase()).deleteTable();
}
