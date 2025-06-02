import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';

abstract class DeleteRevisionQuizFactory {
  Future<void> disableRevisionQuizByIdQuiz(int idQuiz);
  Future<void> deleteTable();
}

class DeleteRevisionQuiz implements DeleteRevisionQuizFactory {
  RevisionQuizDatabaseFactory revisionQuizDatabaseFactory;

  DeleteRevisionQuiz(this.revisionQuizDatabaseFactory);

  @override
  Future<void> disableRevisionQuizByIdQuiz(int idQuiz) async {
    await revisionQuizDatabaseFactory.disableRevisionQuizByIdQuiz(idQuiz);
  }

  @override
  Future<void> deleteTable() async {
    await revisionQuizDatabaseFactory.deleteTable();
  }
}
