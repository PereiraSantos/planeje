import 'package:planeje/revision_theme/datasource/datasource/revision_theme_datasource.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/utils/find_revision_theme.dart';
import 'package:planeje/revision_theme/utils/register_revision_theme.dart';
import 'package:planeje/sync/list_info.dart';

class RevisionThemeController {
  List<ListInfo> revisionThemeInfos = [];

  Future<bool> writeRevisionTheme() async {
    List<ListInfo> listInfoUpdate = [...revisionThemeInfos.where((item) => item.update)];

    revisionThemeInfos.removeWhere((item) => item.update);

    if (listInfoUpdate.isNotEmpty) {
      await UpdateRevisionTheme(
        RevisionThemeDatabaseDataSource(),
        revisionThemes: listInfoUpdate.map<RevisionTheme>((e) => e.lists).toList(),
      ).writeList();
    }

    if (revisionThemeInfos.isNotEmpty) {
      await RegisterRevisioTheme(
        RevisionThemeDatabaseDataSource(),
        revisionThemes: revisionThemeInfos.map<RevisionTheme>((e) => e.lists).toList(),
      ).writeList();
    }

    return true;
  }

  Future<RevisionTheme?> findRevisionThemeByIdExternal(int idExternal) async {
    return await FindRevisionTheme(RevisionThemeDatabaseDataSource()).findRevisionThemeByIdExternal(idExternal);
  }
}
