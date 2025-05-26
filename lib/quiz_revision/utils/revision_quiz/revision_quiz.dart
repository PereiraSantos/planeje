import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';

abstract class FindRevisionQuizFactory {
  Future<List<RevisionQuiz>?> getAllRevisionQuiz(String text);
  Future<List<RevisionQuiz>?> findAllRevisionQuizSync();
  Future<RevisionQuiz?> findRevisionQuizByIdExternal(int idExternal);
  Future<List<RevisionQuiz>?> findRevisionQuizDisable();
}

class GetRevisionQuiz implements FindRevisionQuizFactory {
  RevisionQuizDatabaseFactory revisionQuizDatabaseFactory;

  GetRevisionQuiz(this.revisionQuizDatabaseFactory);

  @override
  Future<List<RevisionQuiz>?> getAllRevisionQuiz(String text) async {
    return await revisionQuizDatabaseFactory.getAllRevisionQuiz(text);
  }

  @override
  Future<List<RevisionQuiz>?> findAllRevisionQuizSync() async {
    return await revisionQuizDatabaseFactory.findAllRevisionQuizSync();
  }

  @override
  Future<RevisionQuiz?> findRevisionQuizByIdExternal(int idExternal) async {
    return await revisionQuizDatabaseFactory.findRevisionQuizByIdExternal(idExternal);
  }

  @override
  Future<List<RevisionQuiz>?> findRevisionQuizDisable() async {
    return await revisionQuizDatabaseFactory.findRevisionQuizDisable();
  }
}
