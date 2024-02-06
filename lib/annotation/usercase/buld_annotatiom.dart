import '../../usercase/format_date.dart';
import '../entities/annotation.dart';

class BuildAnnotation {
  Annotation build(String text, int? idRevision) {
    return Annotation(
      text: text,
      dateText: FormatDate().formatDate(DateTime.now()),
      idRevision: idRevision,
    );
  }
}
