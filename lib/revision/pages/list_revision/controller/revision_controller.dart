import '../../../datasource/database/revision_database_datasource.dart';
import '../../../entities/revision.dart';
import '../../../usercase/revision_usercase.dart';

class RevisionListController {
  RevisionUsercase revisionUsercase = RevisionUsercase(RevisionDatabaseDataSource());

  Future<List<Revision>> getRevision({String? value}) async {
    return value != null && value != ""
        ? await revisionUsercase.findRevisionByDescription('%$value%')
        : await revisionUsercase.findAllRevisions();
  }

  Future<bool> onClickDelete(int id) async {
    var result = await revisionUsercase.deleteRevisionById(id);
    if (result != null) return true;
    return false;
  }
}
