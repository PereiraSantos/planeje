import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import '../../../../database/app_database.dart';

class FindRevisionDao {
  Future<List<RevisionTime>> findRevision(
    AppDatabase database,
    String text,
    int id,
    bool isBefore, {
    int? limit,
  }) async {
    List<RevisionTime> listRevisionTime = [];
    String filter = text != ''
        ? 'where r.id_revision_theme = $id and r.disable = 0 and (r.title like \'%$text%\' or r.description like \'%$text%\')'
        : 'where r.id_revision_theme = $id and r.disable = 0';

    String sqlBase =
        'SELECT r.*, d.* FROM revision as r left join date_revision as d on r.id = d.id_revision $filter group by r.id order by d.date_revision desc';

    List<Map> list = await database.database.rawQuery(sqlBase);

    for (var element in list) {
      listRevisionTime.add(
        RevisionTime(
          Revision(
            dateCreational: element['date_creational'],
            description: element['description'],
            id: element['id'],
            title: element['title'],
            idRevisionTheme: element['id_revision_theme'],
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
