import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';

abstract class IFindRevision {
  Future<List<RevisionTime>> findRevisionByDescription(text);
}

class GetRevision implements IFindRevision {
  RevisionDataSourceRepository revisiondatabase;

  GetRevision(this.revisiondatabase);
  @override
  Future<List<RevisionTime>> findRevisionByDescription(text) async {
    return await revisiondatabase.findRevisionByDescription(text);
  }
}
