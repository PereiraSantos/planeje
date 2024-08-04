import 'dart:developer';

import 'package:planeje/annotation/entities/annotation_revision.dart';

import '../../../../database/app_database.dart';

class AnnotationDaoCustom {
  Future<List<AnnotationRevision>> getAnnotationWidthRevision(
      AppDatabase databaseInstance, String text) async {
    try {
      String sql = text != ''
          ? 'select annotation.id, annotation.title, annotation.text, annotation.date_text, annotation.id_revision, annotation.id_category, revision.description, category.description as descriptionCategory from annotation LEFT JOIN revision  ON annotation.id_revision == revision.id LEFT JOIN category ON annotation.id_category == category.id where text LIKE \'%$text%\''
          : 'select annotation.id, annotation.title, annotation.text, annotation.date_text, annotation.id_revision, annotation.id_category, revision.description, category.description as descriptionCategory from annotation LEFT JOIN revision  ON annotation.id_revision == revision.id LEFT JOIN category ON annotation.id_category == category.id';

      List<Map<String, Object?>> result = await databaseInstance.database.rawQuery(sql);

      if (result.isNotEmpty) return Future.value(result.map((e) => AnnotationRevision.fromJson(e)).toList());

      return Future.value([]);
    } catch (e) {
      log(e.toString());
      return Future.value([]);
    }
  }
}
