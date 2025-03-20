import 'package:planeje/dashboard/entities/revision_data.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/utils/format_date.dart';

class BuildDataGraphic {
  int jan = 0;
  int fev = 0;
  int mar = 0;
  int abr = 0;
  int mai = 0;
  int jun = 0;
  int jul = 0;
  int ago = 0;
  int set = 0;
  int out = 0;
  int nov = 0;
  int dez = 0;

  List<RevisionData> buildRevisionYear(List<DateRevision> dateRevision) {
    for (DateRevision item in dateRevision) {
      if (item.dateRevision != null) {
        DateTime date = FormatDate.dateTimeParse(item.dateRevision!);

        if (FormatDate.newDate().day - date.day <= 360) {
          if (date.month == 1) jan++;
          if (date.month == 2) fev++;
          if (date.month == 3) mar++;
          if (date.month == 4) abr++;
          if (date.month == 5) mai++;
          if (date.month == 6) jun++;
          if (date.month == 7) jul++;
          if (date.month == 8) ago++;
          if (date.month == 9) set++;
          if (date.month == 10) out++;
          if (date.month == 11) nov++;
          if (date.month == 12) dez++;
        }
      }
    }

    return [
      RevisionData('Jan.', jan),
      RevisionData('Fev.', fev),
      RevisionData('Mar.', mar),
      RevisionData('Abr.', abr),
      RevisionData('Mai.', mai),
      RevisionData('Jun.', jun),
      RevisionData('Jul.', jul),
      RevisionData('Ago.', ago),
      RevisionData('Set.', set),
      RevisionData('Out.', out),
      RevisionData('Nov.', nov),
      RevisionData('Dez.', dez),
    ];
  }
}
