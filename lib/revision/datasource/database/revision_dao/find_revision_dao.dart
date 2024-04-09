import 'package:planeje/revision/entities/revision.dart';

import '../../../../database/app_database.dart';
import '../../../entities/date_revision.dart';
import '../../../entities/revision_time.dart';

class FindRevisionDao {
  Future<AppDatabase> getInstance() async {
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  Future<List<RevisionTime>> findRevision() async {
    final database = await getInstance();
    List<RevisionTime> listRevisionTime = [];

    List<Map> list = await database.database.rawQuery(
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


// database.query('SELECT * FROM revision');