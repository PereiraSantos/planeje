import 'package:planeje/utils/format_date.dart';

abstract class IRevisionValid {
  bool validate(DateTime dateRevision);
}

class ValidateIsBefore implements IRevisionValid {
  @override
  bool validate(DateTime dateRevision) {
    return dateRevision.isBefore(FormatDate.newDate());
  }
}

class ValidateIsAfter implements IRevisionValid {
  @override
  bool validate(DateTime dateRevision) {
    return dateRevision.isAfter(FormatDate.newDate());
  }
}
