import 'package:dio/dio.dart';
import 'package:planeje/revision_theme/datasource/datasource/revision_theme_datasource.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/utils/find_revision_theme.dart';
import 'package:planeje/revision_theme/utils/register_revision_theme.dart';
import 'package:planeje/sync/list_info.dart';
import 'package:planeje/sync/revision_theme/revision_theme_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';

class RevisionThemeSync {
  Future<bool> getRevisionTheme() async {
    Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.theme]).get();

    RevisionThemeController revisionThemeController = RevisionThemeController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        RevisionTheme revisionTheme = RevisionTheme.fromMapToObject(item);
        RevisionTheme? revisionThemeDatabase = await revisionThemeController.findRevisionThemeByIdExternal(revisionTheme.idExternal!);

        if (revisionThemeDatabase != null) revisionTheme.id = revisionThemeDatabase.id;

        revisionThemeController.revisionThemeInfos.add(ListInfo(lists: revisionTheme, update: (revisionTheme.id != null)));
      }

      await revisionThemeController.writeRevision();
    }
    return true;
  }

  Future<bool> postRevisionTheme() async {
    List<RevisionTheme> lists = await FindRevisionTheme(RevisionThemeDatabaseDataSource()).findAllRevisionThemeSync() ?? [];

    if (lists.isNotEmpty) {
      for (RevisionTheme item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.theme]).post(RevisionTheme.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await UpdateRevisionTheme(RevisionThemeDatabaseDataSource(), revisionTheme: item).write();
        }
      }
    }
    return true;
  }
}
