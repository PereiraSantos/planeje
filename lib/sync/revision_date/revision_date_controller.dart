import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/utils/delete_date_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';

class RevisionDateController {
  List<DateRevision> revisionDates = [];

  Future<bool> writeRevisionData() async {
    if (revisionDates.isNotEmpty) await RegisterDateRevision(DateRevisionDatabase(), dateRevisions: revisionDates).writeDateRevisionList();

    return true;
  }

  Future<void> deteleTable() async => await DeleteDateRevision(DateRevisionDatabase()).deleteTable();
}
