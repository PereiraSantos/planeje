import 'package:planeje/revision_theme/datasource/datasource/revision_theme_datasource.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/utils/delete.dart';

abstract class DeleteRevisionThemeFactory extends DeleteFactory {}

class DeleteRevisionTheme implements DeleteRevisionThemeFactory {
  final RevisionThemeDatabaseFactory revisionThemeDatabase;

  DeleteRevisionTheme(this.revisionThemeDatabase);

  @override
  Future<RevisionTheme?> deleteById(int id) async {
    return await revisionThemeDatabase.deleteRevisionThemeById(id);
  }

  @override
  Future<void> deleteByIdRevision(int id) {
    throw UnimplementedError();
  }
}
