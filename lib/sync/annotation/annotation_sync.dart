import 'package:dio/dio.dart';
import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/sync/annotation/annotation_controller.dart';
import 'package:planeje/sync/list_info.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';

class AnnotationSync {
  Future<bool> getAnnotation() async {
    Response response = await Network(ConfigApi(), [Endpoint.annotation]).get();

    AnnotationController annotationController = AnnotationController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        Annotation annotation = Annotation.fromMapToObject(item);

        int? id = await annotationController.isRegistration(annotation.id!);

        annotationController.annotationInfos.add(ListInfo(lists: annotation, update: (id == 1)));
      }

      await annotationController.writeRevision();
    }
    return true;
  }

  Future<bool> postAnnotation() async {
    List<Annotation> lists = await GetAnnotation(AnnotationDatabase()).findAnnotationSync() ?? [];

    if (lists.isNotEmpty) {
      for (Annotation item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.annotation]).post(Annotation.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await UpdateAnnotation(AnnotationDatabase(), annotation: item).write();
        }
      }
    }
    return true;
  }
}
