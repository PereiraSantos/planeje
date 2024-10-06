import 'package:planeje/dashboard/controller/reviser_notifier.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/utils/format_date.dart';

abstract class FindRevisionFactory {
  Future<void> getRevision();
  late ReviserNotifier reviserNotifier;
}

class GetDelayedRevision implements FindRevisionFactory {
  GetDelayedRevision(this.reviserNotifier);

  @override
  Future<void> getRevision() async {
    int total =
        await GetRevision(RevisionDatabaseDataSource()).getQuantiyRevision(FormatDate.getDateNumber(), false);
    if (total > 0) reviserNotifier.updateDelayed(total);
  }

  @override
  ReviserNotifier reviserNotifier;
}

class GetCompletedRevision implements FindRevisionFactory {
  GetCompletedRevision(this.reviserNotifier);

  @override
  Future<void> getRevision() async {
    int total =
        await GetRevision(RevisionDatabaseDataSource()).getQuantiyRevision(FormatDate.getDateNumber(), true);
    if (total > 0) reviserNotifier.updateQuantityCompleted(total);
  }

  @override
  ReviserNotifier reviserNotifier;
}
