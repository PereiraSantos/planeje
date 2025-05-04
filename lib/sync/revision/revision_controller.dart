import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/sync/list_info.dart';

class RevisionController {
  List<ListInfo> revisionInfos = [];

  Future<bool> writeRevision() async {
    List<ListInfo> listInfoUpdate = [...revisionInfos.where((item) => item.update)];

    revisionInfos.removeWhere((item) => item.update);

    if (listInfoUpdate.isNotEmpty) {
      await Update(
        RevisionDatabaseDataSource(),
        revisions: listInfoUpdate.map<Revision>((e) => e.lists).toList(),
      ).writeList();
    }

    if (revisionInfos.isNotEmpty) {
      await Register(
        RevisionDatabaseDataSource(),
        revisions: revisionInfos.map<Revision>((e) => e.lists).toList(),
      ).writeList();
    }

    return true;
  }

  Future<int?> isRegistration(int id) async {
    return await GetRevision(RevisionDatabaseDataSource()).isRegistration(id);
  }
}
