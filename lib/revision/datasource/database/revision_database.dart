import 'package:planeje/database/app_database.dart';
import 'package:planeje/revision/datasource/dao/find_revision_dao.dart';

import '../../entities/revision.dart';
import '../../entities/revision_time.dart';

abstract class RevisionDatabaseFactory {
  Future<List<Revision>> findAllRevisions();
  Future<Revision?> findRevisionById(int id);
  Future<Revision?> disableRevisionById(int id);
  Future<List<RevisionTime>> findRevisionByDescription(String text, int id, bool isBefore, {int? limit});
  Future<int?> updateRevision(Revision revision);
  Future<int?> insertRevision(Revision revision);
  Future<List<int>> insertRevisionList(List<Revision> revisions);
  Future<int> getQuantiyRevision(String date, bool isBefore);
  Future<List<Revision>?> findAllRevisionsSync();
  Future<void> updateRevisionList(List<Revision> revision);
  Future<List<Revision>?> findRevisioByIdRevisionTheme(int idRevisionTheme);
  Future<List<Revision>?> findRevisionDisable();
  Future<void> deleteTable();
}

class RevisionDatabase implements RevisionDatabaseFactory {
  @override
  Future<Revision?> disableRevisionById(int id) async {
    final database = await getInstance();
    return await database.revisionDao.disableRevisionById(id);
  }

  @override
  Future<List<Revision>> findAllRevisions() async {
    final database = await getInstance();
    return await database.revisionDao.findAllRevisions();
  }

  @override
  Future<List<RevisionTime>> findRevisionByDescription(String text, int id, bool isBefore, {int? limit}) async {
    final database = await getInstance();
    return await FindRevisionDao().findRevision(database, text, id, isBefore, limit: limit);
  }

  @override
  Future<Revision?> findRevisionById(int id) async {
    final database = await getInstance();
    return await database.revisionDao.findRevisionById(id);
  }

  @override
  Future<int?> insertRevision(Revision revision) async {
    final database = await getInstance();
    return await database.revisionDao.insertRevision(revision);
  }

  @override
  Future<int?> updateRevision(Revision revision) async {
    final database = await getInstance();
    return await database.revisionDao.updateRevision(revision);
  }

  @override
  Future<int> getQuantiyRevision(String date, bool isBefore) async {
    // final database = await getInstance();
    //  return await FindRevisionDao().getQuantiyRevision(database, date, isBefore);
    return 0;
  }

  @override
  Future<List<int>> insertRevisionList(List<Revision> revisions) async {
    final database = await getInstance();
    return await database.revisionDao.insertRevisionList(revisions);
  }

  @override
  Future<List<Revision>?> findAllRevisionsSync() async {
    final database = await getInstance();
    return await database.revisionDao.findAllRevisionsSync();
  }

  @override
  Future<void> updateRevisionList(List<Revision> revision) async {
    final database = await getInstance();
    return await database.revisionDao.updateRevisionList(revision);
  }

  @override
  Future<List<Revision>?> findRevisioByIdRevisionTheme(int idRevisionTheme) async {
    final database = await getInstance();
    return await database.revisionDao.findRevisioByIdRevisionTheme(idRevisionTheme);
  }

  @override
  Future<List<Revision>?> findRevisionDisable() async {
    final database = await getInstance();
    return await database.revisionDao.findRevisionDisable();
  }

  @override
  Future<void> deleteTable() async {
    final database = await getInstance();
    return await database.revisionDao.deleteTable();
  }
}
