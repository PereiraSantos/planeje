import '../../utils/format_date.dart';
import '../entities/revision.dart';

class BuildRevision {
  Revision build({
    required String description,
    required String nextDate,
    required String timeInit,
    required String timeEnd,
  }) {
    return Revision(
      description: description,
      date: buildDate(),
      nextDate: nextDate,
      timeInit: timeInit,
      timeEnd: timeEnd,
    );
  }

  String buildDate() {
    DateTime dateNow = DateTime.now();
    return FormatDate.formatDate(dateNow);
  }
}
