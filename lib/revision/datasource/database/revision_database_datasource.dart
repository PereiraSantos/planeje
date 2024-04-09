import 'package:planeje/database/app_database.dart';
import 'package:planeje/revision/datasource/database/revision_dao/find_revision_dao.dart';

import '../../entities/revision.dart';
import '../../entities/revision_time.dart';
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
  Future<List<RevisionTime>> findRevisionByDescription(String text) async {
    return await FindRevisionDao().findRevision();
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
}
