import '../../revision/datasource/database/revision_database_datasource.dart';
import '../../revision/entities/revision_time.dart';
import '../../revision/usercase/revision_usercase.dart';
import '../../utils/format_date.dart';
import '../component/reviser_notifier.dart';

class DashboardController {
  ReviserNotifier reviserNotifier = ReviserNotifier();
  RevisionUsercase revisionUsercase = RevisionUsercase(RevisionDatabaseDataSource());

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
    List<RevisionTime> revision = [];
    List<RevisionTime> revisionTimeTemp = await revisionUsercase.findRevisionByDescription('');

    for (var element in revisionTimeTemp) {
      revision.add(element);
    }

    int total = 0;
    for (var element in revision) {
      var dateRevision = FormatDate.dateParse(element.dateRevision.nextDate!);

      if (dateRevision.isBefore(FormatDate.newDate())) total++;
    }

    reviserNotifier.updateDelayed(total);
  }

  Future<void> getCompletedRevision() async {
    List<RevisionTime> revision = [];
    List<RevisionTime> revisionTimeTemp = await revisionUsercase.findRevisionByDescription('');
    var total = 0;
    for (var element in revisionTimeTemp) {
      var dateRevision = FormatDate.dateParse(element.dateRevision.nextDate!);
      if (dateRevision.isAfter(FormatDate.newDate())) total++;
      revision.add(element);
    }

    reviserNotifier.updateQuantityCompleted(total);
    //getQuantityHour(revision);
  }

  void getQuantityHour(List<RevisionTime> listRevision) {
    double month = 0;
    double week = 0;

    for (var element in listRevision) {
      var dateRevision = FormatDate.dateParse(element.dateRevision.nextDate!);
      var timeInit = FormatDate.timeParse(element.dateRevision.hourInit!);
      var timeEnd = FormatDate.timeParse(element.dateRevision.hourEnd!);

      var result = double.parse((timeEnd.hour + timeEnd.minute).toString()) -
          double.parse((timeInit.hour + timeInit.minute).toString());

      if (dateRevision.isAfter(FormatDate.newDate())) {
        if (result > 0) week = week + result;
      }
      if (result > 0) month = month + result;
    }

    reviserNotifier.updateQuantityHourMonth(month);
    reviserNotifier.updateQuantityHourWeek(week);
  }
}
