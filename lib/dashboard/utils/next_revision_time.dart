import 'package:planeje/dashboard/utils/valid_date.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/utils/format_date.dart';

class NetRevisionTime {
  NetRevisionTime(this.revisionValid);

  IRevisionValid revisionValid;
  List<RevisionTime> revisions = [];
  List<RevisionTime> revisionTimes = [];
  var total = 0;

  Future<void> findNextRevision() async =>
      revisionTimes = await GetRevision(RevisionDatabaseDataSource()).findRevisionByDescription('');

  Future<List<RevisionTime>?> getNextRevision() async {
    await findNextRevision();

    for (var element in revisionTimes) {
      if (revisionValid.validate(FormatDate.dateParse(element.dateRevision.nextDate!))) {
        revisions.add(element);
      }

      if (revisions.length > 2) break;
    }

    return revisions;
  }
}
