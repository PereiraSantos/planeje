import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';

import '../entities/revision.dart';
import '../entities/revision_time.dart';
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
  Future<List<RevisionTime>> findRevisionByDescription(String text) async {
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
  Future<int?> updateRevision(Revision revision) async {
    return await databaseDataSource.updateRevision(revision);
  }

  Revision buildRevision({required String description, required dateCriational, int? id}) {
    return Revision(id: id, description: description, dateCreational: dateCriational);
  }
}
