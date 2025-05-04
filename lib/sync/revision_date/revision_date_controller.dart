import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/utils/find_date_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/sync/list_info.dart';

class RevisionDateController {
  List<ListInfo> revisionDateInfos = [];

  Future<bool> writeRevision() async {
    List<ListInfo> listInfoUpdate = [...revisionDateInfos.where((item) => item.update)];

    revisionDateInfos.removeWhere((item) => item.update);

    if (listInfoUpdate.isNotEmpty) {
      await UpdateDateRevision(
        DateRevisionDatabaseDataSource(),
        dateRevisions: listInfoUpdate.map<DateRevision>((e) => e.lists).toList(),
      ).writeDateRevisionList();
    }

    if (revisionDateInfos.isNotEmpty) {
      await RegisterDateRevision(
        DateRevisionDatabaseDataSource(),
        dateRevisions: revisionDateInfos.map<DateRevision>((e) => e.lists).toList(),
      ).writeDateRevisionList();
    }

    return true;
  }

  Future<int?> isRegistration(int id) async {
    return await GetDateRevision(DateRevisionDatabaseDataSource()).isRegistration(id);
  }
}
