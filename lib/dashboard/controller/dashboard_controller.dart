import '../../revision/datasource/database/revision_database_datasource.dart';
import '../../revision/entities/revision.dart';
import '../../revision/entities/revision_time.dart';
import '../../revision/usercase/revision_usercase.dart';
import '../../utils/format_date.dart';
import '../component/reviser_notifier.dart';

class DashboardController {
  ReviserNotifier reviserNotifier = ReviserNotifier();
  RevisionUsercase revisionUsercase = RevisionUsercase(RevisionDatabaseDataSource());

  updateQuantity(int value) {
    reviserNotifier.updateQuantityCompleted(value);
  }

  Future<List<RevisionTime>?> getNextRevisionLate() async {
    List<RevisionTime> revision = [];
    List<RevisionTime> revisionTimeTemp = await revisionUsercase.findRevisionByDescription('');

    for (var element in revisionTimeTemp) {
      var dateRevision = FormatDate.dateParse(element.dateRevision.nextDate!);

      if (dateRevision.isBefore(FormatDate.newDate())) revision.add(element);
      if (revision.length > 2) break;
    }

    return revision;
  }

  Future<List<RevisionTime>?> getNextRevision() async {
    List<RevisionTime> revision = [];
    List<RevisionTime> revisionTimeTemp = await revisionUsercase.findRevisionByDescription('');

    for (var element in revisionTimeTemp) {
      var dateRevision = FormatDate.dateParse(element.dateRevision.nextDate!);
      if (dateRevision.isAfter(FormatDate.newDate())) revision.add(element);
      if (revision.length > 2) break;
    }

    return revision;
  }

  Future<void> getDelayedRevision() async {
    List<Revision> revision = [];
    List<RevisionTime> revisionTimeTemp = await revisionUsercase.findRevisionByDescription('');

    for (var element in revisionTimeTemp) {
      revision.add(element.revision);
    }

    int total = 0;
    for (var element in revision) {
      //  if (element.nextDate != null && element.nextDate != "") {
      DateTime nextDate = FormatDate.dateParse('01/02/204');
      DateTime date = DateTime.now();

      if (nextDate.isBefore(date)) total++;
      //  }
    }

    reviserNotifier.updateDelayed(total);
  }

  Future<void> getCompletedRevision() async {
    List<Revision> revision = [];
    List<RevisionTime> revisionTimeTemp = await revisionUsercase.findRevisionByDescription('');

    for (var element in revisionTimeTemp) {
      revision.add(element.revision);
    }
    reviserNotifier.updateQuantityCompleted(revision.length);
    getQuantityHour(revision);
  }

  void getQuantityHour(List<Revision> listRevision) {
    double month = 0;
    double week = 0;

    for (var element in listRevision) {
      //var time = FormatDate().dateParse(element.nextDate!);

      // var result = double.parse(element.timeEnd!) - double.parse(element.timeInit!);

      //print(result);
    }

    reviserNotifier.updateQuantityHourMonth(month);
    reviserNotifier.updateQuantityHourWeek(week);
  }
}
