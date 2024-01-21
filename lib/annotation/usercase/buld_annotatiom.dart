import '../../usercase/format_date.dart';
import '../entities/annotation.dart';

class BuildAnnotation {
  Annotation build(String text) {
    return Annotation(text: text, dateText: FormatDate().formatDate(DateTime.now()));
  }
}
