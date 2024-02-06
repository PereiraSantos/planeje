import 'dart:developer';

import '../../../../database/app_database.dart';
import '../../../entities/annotation_revision.dart';

class AnnotationDaoCustom {
  Future<List<AnnotationRevision>> getAnnotationWidthRevision(AppDatabase databaseInstance) async {
    try {
      String sql =
          'select annotation.id, annotation.text, annotation.date_text, annotation.id_revision, revision.next_date, revision.date, revision.description, revision.status from annotation LEFT JOIN revision  ON annotation.id_revision == revision.id';

      List<Map<String, Object?>> result = await databaseInstance.database.rawQuery(sql);

      if (result.isNotEmpty) {
        return Future.value(result.map((e) => AnnotationRevision.fromJson(e)).toList());
      }
      return Future.value([]);
    } catch (e) {
      log(e.toString());
      return Future.value([]);
    }
  }
}
