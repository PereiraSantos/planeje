import 'package:planeje/database/app_database.dart';

import '../../entities/revision.dart';
import '../repository/datasource_revision_repository.dart';

class RevisionDatabaseDataSource implements RevisionDataSourceRepository {
  Future<AppDatabase> getInstance() async {
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

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
  Future<List<Revision>> findRevisionByDescription(String text) async {
    final database = await getInstance();
    return await database.revisionDao.findRevisionByDescription(text);
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
  Future<int?> updateRevision(String description, String nextDate, int id, bool status) async {
    final database = await getInstance();
    return await database.revisionDao.updateRevision(description, nextDate, id, status);
  }

  @override
  Future<List<Revision>?> getNextRevisionLate() async {
    final database = await getInstance();
    return await database.revisionDao.getNextRevisionLate();
  }

  @override
  Future<List<Revision>?> getNextRevision() async {
    final database = await getInstance();
    return await database.revisionDao.getNextRevision();
  }

  @override
  Future<List<Revision>?> getDelayedRevision() async {
    final database = await getInstance();
    return await database.revisionDao.getDelayedRevision();
  }

  @override
  Future<List<Revision>?> getCompletedRevision() async {
    final database = await getInstance();
    return await database.revisionDao.getCompletedRevision();
  }
}
