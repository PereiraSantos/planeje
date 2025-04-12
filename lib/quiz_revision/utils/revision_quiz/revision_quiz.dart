import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';

abstract class FindRevisionQuizFactory {
  Future<List<RevisionQuiz>?> getAllRevisionQuiz(String text);
}

class GetRevisionQuiz implements FindRevisionQuizFactory {
  RevisionQuizDatabaseFactory revisionQuizDatabaseFactory;

  GetRevisionQuiz(this.revisionQuizDatabaseFactory);

  @override
  Future<List<RevisionQuiz>?> getAllRevisionQuiz(String text) async {
    return await revisionQuizDatabaseFactory.getAllRevisionQuiz(text);
  }
}
