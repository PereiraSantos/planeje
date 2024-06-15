import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';

import '../../../../database/app_database.dart';

class FindRevisionDao {
  Future<List<RevisionTime>> findRevision(AppDatabase database, String text) async {
    List<RevisionTime> listRevisionTime = [];
    List<Map> list = text != ''
        ? await database.database.rawQuery(
            'SELECT * FROM revision  inner join date_revision on revision.id = date_revision.id_revision where description LIKE \'%$text%\'')
        : await database.database.rawQuery(
            'SELECT * FROM revision inner join date_revision on revision.id = date_revision.id_revision');

    for (var element in list) {
      listRevisionTime.add(
        RevisionTime(
          Revision(
            dateCreational: element['date_creational'],
            description: element['description'],
            id: element['id'],
          ),
          DateRevision(
              dateRevision: element['date_revision'],
              hourEnd: element['hour_end'],
              hourInit: element['hour_init'],
              idRevision: element['id_revision'],
              nextDate: element['next_date_revision'],
              id: element['id_date']),
        ),
      );
    }
    return listRevisionTime;
  }
}
