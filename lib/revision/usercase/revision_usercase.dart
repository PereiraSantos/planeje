import 'package:planeje/entities/revision.dart';
import 'package:planeje/revision/datasource/database/database_datasource.dart';

import '../repository/revision_repository.dart';

class RevisionUsercase implements IRevisionRepository {
  final DatabaseDataSource databaseDataSource;

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
  Future<int?> updateRevision(description, int id, bool status) async {
    return await databaseDataSource.updateRevision(description, id, status);
  }
}
