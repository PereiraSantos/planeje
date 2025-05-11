import 'package:dio/dio.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/sync/revision/revision_controller.dart';
import 'package:planeje/sync/list_info.dart';
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

        Revision? revisionDatabase = await revisionController.findRevisionByIdExternal(revision.idExternal!);

        if (revisionDatabase != null) revision.id = revisionDatabase.id;

        revisionController.revisionInfos.add(ListInfo(lists: revision, update: (revision.id != null)));
      }

      await revisionController.writeRevision();
    }
    return true;
  }

  Future<bool> postRevision() async {
    List<Revision>? lists = await GetRevision(RevisionDatabaseDataSource()).findAllRevisionsSync() ?? [];

    if (lists.isNotEmpty) {
      for (Revision item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.revision]).post(Revision.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await Update(RevisionDatabaseDataSource(), revision: item).write();
        }
      }
    }

    return true;
  }
}
