import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/utils/delete_revision_theme.dart';
import 'package:planeje/revision_theme/utils/register_revision_theme.dart';

class RevisionThemeController {
  List<RevisionTheme> revisionThemes = [];

  Future<bool> writeRevisionTheme() async {
    if (revisionThemes.isNotEmpty) await RegisterRevisioTheme(RevisionThemeDatabase(), revisionThemes: revisionThemes).writeList();

    return true;
  }

  Future<void> deteleTable() async => await DeleteRevisionTheme(RevisionThemeDatabase()).deleteTable();
}
