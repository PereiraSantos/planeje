import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';

abstract class FindRevisionFactory {
  Future<List<RevisionTime>> findRevisionByDescription(text);
}

class GetRevision implements FindRevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  GetRevision(this.revisionDatabase);
  @override
  Future<List<RevisionTime>> findRevisionByDescription(text) async {
    return await revisionDatabase.findRevisionByDescription(text);
  }
}
