import '../../revision/datasource/database/revision_database_datasource.dart';
import '../../revision/entities/revision.dart';
import '../../revision/usercase/revision_usercase.dart';
import '../../usercase/format_date.dart';
import '../component/reviser_notifier.dart';

class DashboardController {
  ReviserNotifier reviserNotifier = ReviserNotifier();
  RevisionUsercase revisionUsercase = RevisionUsercase(RevisionDatabaseDataSource());

  updateQuantity(int value) {
    reviserNotifier.updateQuantityCompleted(value);
  }

  Future<Revision> getNextRevision() async {
    return await revisionUsercase.getNextRevision() ?? Revision();
  }

  Future<void> getDelayedRevision() async {
    List<Revision> listRevision = await revisionUsercase.getDelayedRevision() ?? [];
    int total = 0;
    for (var element in listRevision) {
      if (element.nextDate != null && element.nextDate != "") {
        DateTime nextDate = FormatDate().dateParse(element.nextDate!);
        DateTime date = DateTime.now();

        if (nextDate.isBefore(date)) total++;
      }
    }

    reviserNotifier.updateDelayed(total);
  }

  Future<void> getCompletedRevision() async {
    List<Revision> listRevision = await revisionUsercase.getCompletedRevision() ?? [];
    reviserNotifier.updateQuantityCompleted(listRevision.length);
  }
}
