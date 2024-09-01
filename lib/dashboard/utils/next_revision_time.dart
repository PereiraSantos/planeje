import 'package:planeje/dashboard/utils/valid_date.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/utils/format_date.dart';

class NetRevisionTime {
  NetRevisionTime(this.revisionValid);

  RevisionValidFactory revisionValid;
  List<RevisionTime> revisions = [];
  var total = 0;

  Future<void> findNextRevision() async =>
      revisions = await GetRevision(RevisionDatabaseDataSource()).findRevisionByDescription('');

  Future<List<RevisionTime>?> getNextRevision() async {
    await findNextRevision();
    List<RevisionTime> nextRevisions = [];

    for (var element in revisions) {
      if (revisionValid.validate(FormatDate.dateParse(element.dateRevision.nextDate!))) {
        nextRevisions.add(element);
      }

      if (nextRevisions.length > 2) break;
    }

    return nextRevisions;
  }
}
