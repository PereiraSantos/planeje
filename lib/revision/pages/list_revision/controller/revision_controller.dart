import '../../../../entities/revision.dart';
import '../../../datasource/database/database_datasource.dart';
import '../../../usercase/revision_usercase.dart';

class RevisionListController {
  RevisionUsercase revisionUsercase = RevisionUsercase(DatabaseDataSource());
  Future<List<Revision>> getRevision({String? value}) async {
    return value != null && value != ""
        ? await revisionUsercase.findRevisionByDescription('%$value%')
        : await revisionUsercase.findAllRevisions();
  }

  onClickDelete(int i) {}

  onClickUpdate(Revision revision) {}
}
