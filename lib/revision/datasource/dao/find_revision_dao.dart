import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';

import '../../../../database/app_database.dart';
/*

with revision_temp as (SELECT * FROM revision as r inner join date_revision as d on r.id == d.id_revision)
select * from revision_temp group by id_revision
*/

class FindRevisionDao {
  Future<List<RevisionTime>> findRevision(AppDatabase database, String text) async {
    List<RevisionTime> listRevisionTime = [];

    List<Map> list = text != ''
        ? await database.database.rawQuery('SELECT * FROM revision where description LIKE \'%$text%\'')
        : await database.database.rawQuery('SELECT * FROM revision');

    for (var element in list) {
      List<Map> listDateRevision = await database.database.rawQuery(
          'SELECT * FROM date_revision where id_revision = ${element['id']} order by id_date desc  limit 1');

      listRevisionTime.add(
        RevisionTime(
          Revision(
            dateCreational: element['date_creational'],
            description: element['description'],
            id: element['id'],
            idLearn: element['id_learn'],
          ),
          DateRevision(
              dateRevision: listDateRevision[0]['date_revision'],
              hourEnd: listDateRevision[0]['hour_end'],
              hourInit: listDateRevision[0]['hour_init'],
              idRevision: listDateRevision[0]['id_revision'],
              nextDate: listDateRevision[0]['next_date_revision'],
              id: listDateRevision[0]['id_date'],
              day: listDateRevision[0]['day'],
              status: listDateRevision[0]['status'] != null
                  ? listDateRevision[0]['status'] == 1
                      ? true
                      : false
                  : false),
        ),
      );
    }
    return listRevisionTime;
  }
}
