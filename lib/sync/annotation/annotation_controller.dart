import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/sync/list_info.dart';

class AnnotationController {
  List<ListInfo> annotationInfos = [];

  Future<bool> writeRevision() async {
    List<ListInfo> listInfoUpdate = [...annotationInfos.where((item) => item.update)];

    annotationInfos.removeWhere((item) => item.update);

    if (listInfoUpdate.isNotEmpty) {
      await UpdateAnnotation(
        AnnotationDatabase(),
        annotations: listInfoUpdate.map<Annotation>((e) => e.lists).toList(),
      ).writeList();
    }

    if (annotationInfos.isNotEmpty) {
      await InsertAnnotation(
        AnnotationDatabase(),
        annotations: annotationInfos.map<Annotation>((e) => e.lists).toList(),
      ).writeList();
    }

    return true;
  }

  Future<int?> isRegistration(int id) async {
    return await GetAnnotation(AnnotationDatabase()).isRegistration(id);
  }
}
