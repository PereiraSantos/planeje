import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/utils/delete.dart';

abstract class DeleteRevisionFactory extends DeleteFactory {}

class DeleteRevision implements DeleteRevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  DeleteRevision(this.revisionDatabase);

  @override
  Future<Revision?> deleteById(int id) async {
    return await revisionDatabase.deleteRevisionById(id);
  }

  @override
  Future<void> deleteByIdRevision(int id) {
    throw UnimplementedError();
  }
}
