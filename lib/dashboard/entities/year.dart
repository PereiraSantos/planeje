import 'package:planeje/dashboard/entities/month.dart';

class Year {
  List<Month> months = [];

  List<Month> buildMonths() {
    for (var i = 0; i < 12; i++) {
      months.add(Month(0, Month.getLabelMonth(i)));
    }

    return months;
  }
}
