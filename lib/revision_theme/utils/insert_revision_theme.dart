import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';

abstract class RevisionThemeFactory {
  Future<int?> write();
  set revisionTheme(RevisionTheme value);
}

class InsertRevisioTheme implements RevisionThemeFactory {
  final RevisionThemeDatabaseFactory _revisionThemeDatabase;

  InsertRevisioTheme(this._revisionThemeDatabase);

  RevisionTheme? _revisionTheme;
  List<RevisionTheme>? _revisionThemes;

  @override
  set revisionTheme(RevisionTheme value) => _revisionTheme = value;

  set revisionThemes(List<RevisionTheme> value) => _revisionThemes = value;

  @override
  Future<int> write() async {
    if (_revisionTheme == null) throw ('Teve passar um objeto revisionTheme');
    return await _revisionThemeDatabase.insertRevisionTheme(_revisionTheme!);
  }

  Future<List<int>> writeList() async {
    if (_revisionThemes == null) throw ('Teve passar a uma lista de revisionThemes');
    return await _revisionThemeDatabase.insertRevisionThemeList(_revisionThemes!);
  }
}
