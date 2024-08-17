import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';

abstract class DeleteRevisionFactory {
  Future<Revision?> deleteRevisionById(int id);
}

class DeleteRevision implements DeleteRevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  DeleteRevision(this.revisionDatabase);

  @override
  Future<Revision?> deleteRevisionById(int id) async {
    return await revisionDatabase.deleteRevisionById(id);
  }
}
