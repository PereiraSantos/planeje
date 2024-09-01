import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';

abstract class FindListQuizFactory {
  Future<List<Quiz>?> getAllQuiz(String text);
}

class GetQuiz implements FindListQuizFactory {
  QuizDatabaseFactory quizDatabase;

  GetQuiz(this.quizDatabase);

  @override
  Future<List<Quiz>?> getAllQuiz(String text) async {
    return await quizDatabase.getAllQuiz(text);
  }
}
