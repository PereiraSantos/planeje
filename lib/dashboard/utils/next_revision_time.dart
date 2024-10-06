import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/utils/format_date.dart';

class NetRevisionTime {
  NetRevisionTime(this.isBefore);

  final bool isBefore;

  Future<List<RevisionTime>?> getNextRevision() async {
    return await GetRevision(RevisionDatabaseDataSource()).findRevisionByDescription(
      '',
      isBefore: isBefore,
      date: FormatDate.getDateNumber(),
    );
  }
}
