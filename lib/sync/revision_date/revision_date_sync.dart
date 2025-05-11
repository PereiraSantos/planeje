import 'package:dio/dio.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/utils/find_date_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/sync/list_info.dart';
import 'package:planeje/sync/revision_date/revision_date_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';

class RevisionDateSync {
  Future<bool> getRevisionDate() async {
    Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.date]).get();

    RevisionDateController revisionDateController = RevisionDateController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        DateRevision dateRevision = DateRevision.fromMapToObject(item);

        DateRevision? dateRevisionDatabase = await revisionDateController.findDateRevisionByIdExternal(dateRevision.idExternal!);

        if (dateRevisionDatabase != null) dateRevision.id = dateRevisionDatabase.id;

        revisionDateController.revisionDateInfos.add(ListInfo(lists: dateRevision, update: (dateRevision.id != null)));
      }

      await revisionDateController.writeRevision();
    }
    return true;
  }

  Future<bool> postRevisionDate() async {
    List<DateRevision>? lists = await GetDateRevision(DateRevisionDatabaseDataSource()).findAllDateRevisionSync() ?? [];

    if (lists.isNotEmpty) {
      for (DateRevision item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.date]).post(DateRevision.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await UpdateDateRevision(DateRevisionDatabaseDataSource(), dateRevision: item).writeDateRevision();
        }
      }
    }
    return true;
  }
}
