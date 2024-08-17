import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';

abstract class RemoveQuizFactory {
  Future<void> deleteQuiz(int id);
}

class DeleteQuiz implements RemoveQuizFactory {
  QuizDatabaseFactory quizDatabase;

  DeleteQuiz(this.quizDatabase);
  @override
  Future<void> deleteQuiz(int id) async {
    await quizDatabase.deleteQuiz(id);
  }
}
