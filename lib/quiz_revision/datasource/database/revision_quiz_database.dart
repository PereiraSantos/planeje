import 'package:planeje/quiz_revision/entities/revision_quiz.dart';

import '../../../database/app_database.dart';

abstract class RevisionQuizDatabaseFactory {
  Future<List<RevisionQuiz>?> getAllRevisionQuiz(String text);
  Future<int> insertRevisionQuiz(RevisionQuiz revisionQuiz);
  Future<void> insertRevisionQuizList(List<RevisionQuiz> revisionQuizs);
  Future<RevisionQuiz?> getRevisionQuizById(int id);
  Future<RevisionQuiz?> disableRevisionQuiz(int id);
  Future<void> disableRevisionQuizByIdQuiz(int idQuiz);
  Future<int> updateRevisionQuiz(RevisionQuiz revisionQuiz);
  Future<List<RevisionQuiz>?> findAllRevisionQuizSync();
  Future<void> updateRevisionQuizList(List<RevisionQuiz> revisionQuiz);
  Future<List<RevisionQuiz>?> findRevisionQuizDisable();
  Future<void> deleteTable();
  Future<List<RevisionQuiz>?> getRevisionQuizByIdQuiz(int idQuiz);
}

class RevisionQuizDatabase implements RevisionQuizDatabaseFactory {
  @override
  Future<RevisionQuiz?> disableRevisionQuiz(int id) async {
    final database = await getInstance();
    return await database.revisionQuizDao.disableRevisionQuiz(id);
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

  @override
  Future<void> insertRevisionQuizList(List<RevisionQuiz> revisionQuizs) async {
    final database = await getInstance();
    return await database.revisionQuizDao.insertRevisionQuizList(revisionQuizs);
  }

  @override
  Future<List<RevisionQuiz>?> findAllRevisionQuizSync() async {
    final database = await getInstance();
    return await database.revisionQuizDao.findAllRevisionQuizSync();
  }

  @override
  Future<void> updateRevisionQuizList(List<RevisionQuiz> revisionQuiz) async {
    final database = await getInstance();
    return await database.revisionQuizDao.updateRevisionQuizList(revisionQuiz);
  }

  @override
  Future<List<RevisionQuiz>?> findRevisionQuizDisable() async {
    final database = await getInstance();
    return await database.revisionQuizDao.findRevisionQuizDisable();
  }

  @override
  Future<void> deleteTable() async {
    final database = await getInstance();
    return await database.revisionQuizDao.deleteTable();
  }

  @override
  Future<void> disableRevisionQuizByIdQuiz(int idQuiz) async {
    final database = await getInstance();
    return await database.revisionQuizDao.disableRevisionQuizByIdQuiz(idQuiz);
  }

  @override
  Future<List<RevisionQuiz>?> getRevisionQuizByIdQuiz(int idQuiz) async {
    final database = await getInstance();
    return await database.revisionQuizDao.getRevisionQuizByIdQuiz(idQuiz);
  }
}
