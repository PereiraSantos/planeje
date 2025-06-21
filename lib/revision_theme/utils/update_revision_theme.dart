import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/utils/insert_revision_theme.dart';

class UpdateRevisionTheme implements RevisionThemeFactory {
  final RevisionThemeDatabaseFactory _revisionThemeDatabase;

  UpdateRevisionTheme(this._revisionThemeDatabase);

  RevisionTheme? _revisionTheme;

  @override
  set revisionTheme(RevisionTheme value) => _revisionTheme = value;

  @override
  Future<int?> write() async {
    if (_revisionTheme == null) throw ('Teve passar um objeto revisionTheme');
    return await _revisionThemeDatabase.updateRevisionTheme(_revisionTheme!);
  }
}
