import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/utils/delete.dart';

abstract class DeleteRevisionThemeFactory extends DeleteFactory {}

class DeleteRevisionTheme implements DeleteRevisionThemeFactory {
  final RevisionThemeDatabaseFactory revisionThemeDatabase;

  DeleteRevisionTheme(this.revisionThemeDatabase);

  @override
  Future<RevisionTheme?> disableById(int id) async {
    return await revisionThemeDatabase.disableRevisionThemeById(id);
  }

  @override
  Future<void> disableByIdRevision(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTable() async {
    await revisionThemeDatabase.deleteTable();
  }
}
