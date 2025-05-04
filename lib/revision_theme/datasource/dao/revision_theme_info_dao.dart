import 'package:planeje/database/app_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme_complement.dart';

class RevisionThemeInfoDao {
  Future<List<RevisionThemeComplement>> findRevisionThemeById(AppDatabase database, String text) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
      String sql = 'SELECT rt.*, ' +
          '(select date_revision from revision as r left join date_revision as dt on dt.id_revision = r.id  where r.id_revision_theme = rt.id order by date_revision desc limit 1) as dateRevision, ' +
          '(select r.title from revision as r left join date_revision as dt on dt.id_revision = r.id  where r.id_revision_theme = rt.id order by date_revision desc limit 1) as title, ' +
          '(select r.description from revision as r left join date_revision as dt on dt.id_revision = r.id  where r.id_revision_theme = rt.id order by date_revision desc limit 1) as revisionDescription ' +
          'FROM revision_theme as rt  order by dateRevision desc';

      if (text != "") sql += 'where WHERE rt.description LIKE order by dateRevision desc';

      List<Map<String, dynamic>> list = await database.database.rawQuery(sql);

      return list.map((e) => RevisionThemeComplement.mapFromObject(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
