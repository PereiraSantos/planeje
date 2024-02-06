import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';

import '../entities/revision.dart';
import '../repository/revision_repository.dart';

class RevisionUsercase implements RevisionRepository {
  final RevisionDatabaseDataSource databaseDataSource;

  RevisionUsercase(this.databaseDataSource);

  @override
  Future<Revision?> deleteRevisionById(int id) async {
    return await databaseDataSource.deleteRevisionById(id);
  }

  @override
  Future<List<Revision>> findAllRevisions() async {
    return await databaseDataSource.findAllRevisions();
  }

  @override
  Future<List<Revision>> findRevisionByDescription(String text) async {
    return await databaseDataSource.findRevisionByDescription(text);
  }

  @override
  Future<Revision?> findRevisionById(int id) async {
    return await databaseDataSource.findRevisionById(id);
  }

  @override
  Future<int?> insertRevision(Revision revision) async {
    return await databaseDataSource.insertRevision(revision);
  }

  @override
  Future<int?> updateRevision(description, String nextDate, int id, bool status) async {
    return await databaseDataSource.updateRevision(description, nextDate, id, status);
  }

  @override
  Future<Revision?> getNextRevision() async {
    return await databaseDataSource.getNextRevision();
  }

  @override
  Future<List<Revision>?> getDelayedRevision() async {
    return await databaseDataSource.getDelayedRevision();
  }

  @override
  Future<List<Revision>?> getCompletedRevision() async {
    return await databaseDataSource.getCompletedRevision();
  }
}
