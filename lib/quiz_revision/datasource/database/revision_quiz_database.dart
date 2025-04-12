import 'package:planeje/quiz_revision/entities/revision_quiz.dart';

import '../../../database/app_database.dart';

abstract class RevisionQuizDatabaseFactory {
  Future<List<RevisionQuiz>?> getAllRevisionQuiz(String text);
  Future<int> insertRevisionQuiz(RevisionQuiz revisionQuiz);
  Future<RevisionQuiz?> getRevisionQuizById(int id);
  Future<RevisionQuiz?> deleteRevisionQuiz(int id);
  Future<int> updateRevisionQuiz(RevisionQuiz revisionQuiz);
}

class RevisionQuizDatabase implements RevisionQuizDatabaseFactory {
  @override
  Future<RevisionQuiz?> deleteRevisionQuiz(int id) async {
    final database = await getInstance();
    return await database.revisionQuizDao.deleteRevisionQuiz(id);
  }

  @override
  Future<List<RevisionQuiz>?> getAllRevisionQuiz(String text) async {
    final database = await getInstance();
    return await database.revisionQuizDao.getAllRevisionQuiz();
  }

  @override
  Future<RevisionQuiz?> getRevisionQuizById(int id) async {
    final database = await getInstance();
    return await database.revisionQuizDao.getRevisionQuizById(id);
  }

  @override
  Future<int> insertRevisionQuiz(RevisionQuiz revisionQuiz) async {
    final database = await getInstance();
    return await database.revisionQuizDao.insertRevisionQuiz(revisionQuiz);
  }

  @override
  Future<int> updateRevisionQuiz(RevisionQuiz revisionQuiz) async {
    final database = await getInstance();
    return await database.revisionQuizDao.updateRevisionQuiz(revisionQuiz);
  }
}
