import 'package:dio/dio.dart';
import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/find_date_revision.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/sync/revision/revision_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';

class RevisionSync {
  Future<bool> getRevision() async {
    Response response = await Network(ConfigApi(), [Endpoint.revision]).get();

    RevisionController revisionController = RevisionController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        Revision revision = Revision.fromMapToObject(item);

        revisionController.revisions.add(revision);
      }

      await revisionController.deleteTable();

      await revisionController.writeRevision();
    }
    return true;
  }

  Future<bool> postRevision() async {
    List<Revision>? lists = await GetRevision(RevisionDatabase()).findAllRevisionsSync() ?? [];

    if (lists.isNotEmpty) {
      for (Revision item in lists) {
        if (item.insertApp!) item.id = null;

        Response response = await Network(ConfigApi(), [Endpoint.revision]).post(Revision.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await Update(RevisionDatabase(), revision: item).write();

          await updateIdRevisionAnnotation(response.data['id']);
          await updateIdRevisionDate(response.data['id']);
        }
      }
    }

    return true;
  }

  Future<void> updateIdRevisionAnnotation(int id) async {
    List<Annotation> annotations = await GetAnnotation(AnnotationDatabase()).getAnnotationWidthIdRevision(id) ?? [];

    if (annotations.isNotEmpty) {
      for (Annotation annotation in annotations) {
        annotation.idRevision = id;

        await UpdateAnnotation(AnnotationDatabase(), annotation: annotation).write();
      }
    }
  }

  Future<void> updateIdRevisionDate(int id) async {
    List<DateRevision> dateRevisions = await GetDateRevision(DateRevisionDatabase()).findDateRevisionByIdRevision(id) ?? [];

    if (dateRevisions.isNotEmpty) {
      for (DateRevision dateRevision in dateRevisions) {
        dateRevision.idRevision = id;

        await UpdateDateRevision(DateRevisionDatabase(), dateRevision: dateRevision).writeDateRevision();
      }
    }
  }

  Future<bool> postRevisionDisable() async {
    List<Revision>? lists = await GetRevision(RevisionDatabase()).findRevisionDisable() ?? [];

    if (lists.isNotEmpty) {
      for (Revision item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.update]).post(Revision.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await Update(RevisionDatabase(), revision: item).write();
        }
      }
    }

    return true;
  }
}
