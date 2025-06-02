import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/delete_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';

class RevisionController {
  List<Revision> revisions = [];

  Future<bool> writeRevision() async {
    if (revisions.isNotEmpty) await Register(RevisionDatabase(), revisions: revisions).writeList();

    return true;
  }

  Future<void> deleteTable() async => await DeleteRevision(RevisionDatabase()).deleteTable();
}
