import 'package:intl/intl.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/utils/format_date.dart';

class BuildDataGraphic {
  int seg = 0;
  int ter = 0;
  int qua = 0;
  int qui = 0;
  int sex = 0;
  int sab = 0;
  int dom = 0;

  List<Map<dynamic, dynamic>> buildRevisionYear(List<DateRevision> dateRevision) {
    return [
      {'revision': 'Jan.', 'quantiy': 20},
      {'revision': 'Fev.', 'quantiy': 11},
      {'revision': 'Mar.', 'quantiy': 15},
      {'revision': 'Abr.', 'quantiy': 12},
      {'revision': 'Mai.', 'quantiy': 18},
      {'revision': 'Jun.', 'quantiy': 30},
      {'revision': 'Jul.', 'quantiy': 25},
      {'revision': 'Ago.', 'quantiy': 8},
      {'revision': 'Set.', 'quantiy': 29},
      {'revision': 'Out.', 'quantiy': 9},
      {'revision': 'Nov.', 'quantiy': 10},
      {'revision': 'Dez.', 'quantiy': 11},
    ];
  }

  List<Map<dynamic, dynamic>> buildRevisionMonth(List<DateRevision> dateRevision) {
    return [
      {'revision': '2-8', 'quantiy': 3},
      {'revision': '9-15', 'quantiy': 4},
      {'revision': '16-22', 'quantiy': 1},
      {'revision': '23-29', 'quantiy': 5}
    ];
  }

  List<Map<dynamic, dynamic>> buildRevisionWeek(List<DateRevision> dateRevision) {
    for (DateRevision item in dateRevision) {
      if (item.dateRevision != null) {
        DateTime date = FormatDate.dateTimeParse(item.dateRevision!);

        if (FormatDate.newDate().day - date.day <= 7) {
          String day = FormatDate().formatDateWek(item.dateRevision!);
          if (day.substring(0, 3) == 'dom') dom++;
          if (day.substring(0, 3) == 'seg') seg++;
          if (day.substring(0, 3) == 'ter') ter++;
          if (day.substring(0, 3) == 'qua') qua++;
          if (day.substring(0, 3) == 'qui') qui++;
          if (day.substring(0, 3) == 'sex') sex++;
          if (day.substring(0, 3) == 'sab') sab++;
        }
      }
    }
    return [
      {'revision': 'Dom', 'quantiy': dom},
      {'revision': 'Seg', 'quantiy': seg},
      {'revision': 'Ter', 'quantiy': ter},
      {'revision': 'Qua', 'quantiy': qua},
      {'revision': 'Qui', 'quantiy': qui},
      {'revision': 'Sex', 'quantiy': sex},
      {'revision': 'Sab', 'quantiy': sab},
    ];
  }
}
