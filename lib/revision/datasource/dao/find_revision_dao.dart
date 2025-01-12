import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import '../../../../database/app_database.dart';

class FindRevisionDao {
  Future<List<RevisionTime>> findRevision(
    AppDatabase database,
    String text,
    bool isBefore, {
    int? limit,
  }) async {
    List<RevisionTime> listRevisionTime = [];

    List<Map> list = await database.database.rawQuery('SELECT * FROM revision as r left join date_revision as d on r.id = d.id_revision group by id');

    for (var element in list) {
      listRevisionTime.add(
        RevisionTime(
          Revision(
            dateCreational: element['date_creational'],
            description: element['description'],
            id: element['id'],
            title: element['title'],
          ),
          DateRevision(
            dateRevision: element['date_revision'],
            idRevision: element['id_revision'],
            id: element['id_date'],
          ),
        ),
      );
    }
    return listRevisionTime;
  }
}
