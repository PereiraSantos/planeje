import '../../utils/format_date.dart';
import '../entities/revision.dart';

class BuildRevision {
  Revision build({
    required String description,
    required String nextDate,
  }) {
    return Revision(
      description: description,
      date: buildDate(),
      nextDate: nextDate,
    );
  }

  String buildDate() {
    DateTime dateNow = DateTime.now();
    return FormatDate.formatDate(dateNow);
  }
}
