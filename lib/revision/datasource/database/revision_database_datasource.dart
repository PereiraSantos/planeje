import 'package:planeje/database/app_database.dart';
import 'package:planeje/revision/datasource/dao/find_revision_dao.dart';

import '../../entities/revision.dart';
import '../../entities/revision_time.dart';

abstract class RevisionDatabaseFactory {
  Future<List<Revision>> findAllRevisions();
  Future<Revision?> findRevisionById(int id);
  Future<Revision?> deleteRevisionById(int id);
  Future<List<RevisionTime>> findRevisionByDescription(String text, bool isBefore, {int? limit});
  Future<int?> updateRevision(Revision revision);
  Future<int?> insertRevision(Revision revision);
  Future<int> getQuantiyRevision(String date, bool isBefore);
}

class RevisionDatabaseDataSource implements RevisionDatabaseFactory {
  @override
  Future<Revision?> deleteRevisionById(int id) async {
    final database = await getInstance();
    return await database.revisionDao.deleteRevisionById(id);
  }

  @override
  Future<List<Revision>> findAllRevisions() async {
    final database = await getInstance();
    return await database.revisionDao.findAllRevisions();
  }

  @override
  Future<List<RevisionTime>> findRevisionByDescription(String text, bool isBefore, {int? limit}) async {
    final database = await getInstance();
    return await FindRevisionDao().findRevision(database, text, isBefore, limit: limit);
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
    final database = await getInstance();
    return await FindRevisionDao().getQuantiyRevision(database, date, isBefore);
  }
}
