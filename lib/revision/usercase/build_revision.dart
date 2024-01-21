import '../../utils/format_date.dart';
import '../entities/revision.dart';

class BuildRevision {
  Revision build({
    required String description,
  }) {
    return Revision(
      description: description,
    );
  }

  String buildDate() {
    DateTime dateNow = DateTime.now();
    return FormatDate.formatDate(dateNow);
  }
}
