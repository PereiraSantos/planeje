import '../../entities/revision.dart';
import '../../utils/format_date.dart';

class BuildRevision {
  Revision build({
    required String description,
    required String nextRevision,
  }) {
    return Revision(
      dateCriation: buildDate(),
      description: description,
      revision: buildDate(),
      nextRevision: nextRevision,
    );
  }

  String buildDate() {
    DateTime dateNow = DateTime.now();
    return FormatDate.formatDate(dateNow);
  }
}
