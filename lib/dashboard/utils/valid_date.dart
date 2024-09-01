import 'package:planeje/utils/format_date.dart';

abstract class RevisionValidFactory {
  bool validate(DateTime dateRevision);
}

class ValidateIsBefore implements RevisionValidFactory {
  @override
  bool validate(DateTime dateRevision) {
    return dateRevision.isBefore(FormatDate.newDate());
  }
}

class ValidateIsAfter implements RevisionValidFactory {
  @override
  bool validate(DateTime dateRevision) {
    return dateRevision.isAfter(FormatDate.newDate());
  }
}
