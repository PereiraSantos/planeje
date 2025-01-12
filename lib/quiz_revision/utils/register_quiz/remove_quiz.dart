import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/utils/delete.dart';

abstract class RemoveQuizFactory extends DeleteFactory {}

class DeleteQuiz implements RemoveQuizFactory {
  QuizDatabaseFactory quizDatabase;

  DeleteQuiz(this.quizDatabase);
  @override
  Future<void> deleteById(int id) async {
    await quizDatabase.deleteQuiz(id);
  }

  @override
  Future<void> deleteByIdRevision(int id) {
    throw UnimplementedError();
  }
}
