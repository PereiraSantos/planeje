import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/utils/delete.dart';

abstract class RemoveQuizFactory extends DeleteFactory {}

class DeleteQuiz implements RemoveQuizFactory {
  QuizDatabaseFactory quizDatabase;

  DeleteQuiz(this.quizDatabase);
  @override
  Future<void> disableById(int id) async {
    await quizDatabase.disableQuiz(id);
  }

  @override
  Future<void> disableByIdRevision(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTable() async {
    await quizDatabase.deleteTable();
  }
}
