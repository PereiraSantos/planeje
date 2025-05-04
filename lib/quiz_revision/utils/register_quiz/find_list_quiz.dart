import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';

abstract class FindListQuizFactory {
  Future<List<Quiz>?> getAllQuiz(String text);
  Future<List<Quiz>?> findAllQuizSync();
  Future<int?> isRegistration(int id);
}

class GetQuiz implements FindListQuizFactory {
  QuizDatabaseFactory quizDatabase;

  GetQuiz(this.quizDatabase);

  @override
  Future<List<Quiz>?> getAllQuiz(String text) async {
    return await quizDatabase.getAllQuiz(text);
  }

  @override
  Future<List<Quiz>?> findAllQuizSync() async {
    return await quizDatabase.findAllQuizSync();
  }

  @override
  Future<int?> isRegistration(int id) async {
    return await quizDatabase.isRegistration(id);
  }
}
