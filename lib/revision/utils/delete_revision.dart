import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';

abstract class IDeleteRevision {
  Future<Revision?> deleteRevisionById(int id);
}

class DeleteRevision implements IDeleteRevision {
  RevisionDataSourceRepository revisiondatabase;

  DeleteRevision(this.revisiondatabase);

  @override
  Future<Revision?> deleteRevisionById(int id) async {
    return await revisiondatabase.deleteRevisionById(id);
  }
}
