import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/utils/format_date.dart';
import '../../../../database/app_database.dart';

class FindRevisionDao {
  Future<List<RevisionTime>> findRevision(
    AppDatabase database,
    String text,
    bool isBefore, {
    int? limit,
  }) async {
    String? date = FormatDate.getDateNumber();

    List<RevisionTime> listRevisionTime = [];

    String filter = 'where description LIKE \'%$text%\'';
    String sql = 'SELECT * FROM revision as r inner join date_revision as d on r.id == d.id_revision';

    if (text != '') sql = '$sql $filter';

    String group = 'select * from revision_temp group by id_revision';

    group =
        'select * from revision_temp where substr(next_date_revision,7)||substr(next_date_revision,4,2)||substr(next_date_revision,1,2) '
        '${isBefore ? '>' : '<='} \'$date\' group by id_revision';

    String cte = 'with revision_temp as ($sql)';

    String sqlBase =
        '$cte $group order by substr(next_date_revision,7)||substr(next_date_revision,4,2)||substr(next_date_revision,1,2) asc';

    if (limit != null) sqlBase = '$sqlBase limit $limit';

    List<Map> list = await database.database.rawQuery(sqlBase);

    for (var element in list) {
      listRevisionTime.add(
        RevisionTime(
          Revision(
            dateCreational: element['date_creational'],
            description: element['description'],
            id: element['id'],
            idLearn: element['id_learn'],
          ),
          DateRevision(
              dateRevision: element['date_revision'],
              hourEnd: element['hour_end'],
              hourInit: element['hour_init'],
              idRevision: element['id_revision'],
              nextDate: element['next_date_revision'],
              id: element['id_date'],
              day: element['day'],
              status: element['status'] != null
                  ? element['status'] == 1
                      ? true
                      : false
                  : false),
        ),
      );
    }
    return listRevisionTime;
  }

  Future<int> getQuantiyRevision(AppDatabase database, String date, bool isBefore) async {
    String sql = 'select count(id_date) as quantity '
        'from date_revision where substr(next_date_revision,7)||substr(next_date_revision,4,2)||substr(next_date_revision,1,2) '
        '${isBefore ? '>' : '<='} \'$date\'';

    List<Map> quantity = await database.database.rawQuery(sql);
    return quantity[0]['quantity'];
  }
}
