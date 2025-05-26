import 'package:planeje/revision_theme/datasource/datasource/revision_theme_datasource.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/entities/revision_theme_complement.dart';

abstract class FindRevisionThemeFactory {
  Future<List<RevisionTheme>> findAllRevisionTheme();
  Future<List<RevisionTheme>?> findAllRevisionThemeSync();
  Future<RevisionTheme?> findRevisionThemeById(int id);
  Future<RevisionTheme?> disableRevisionThemeById(int id);
  Future<List<RevisionThemeComplement>> findRevisionThemeByDescription(String text);
  Future<RevisionTheme?> findRevisionThemeByIdExternal(int idExternal);
  Future<List<RevisionTheme>?> findRevisionThemeDisable();
}

class FindRevisionTheme implements FindRevisionThemeFactory {
  final RevisionThemeDatabaseFactory revisionThemeDatabase;

  FindRevisionTheme(this.revisionThemeDatabase);

  @override
  Future<RevisionTheme?> disableRevisionThemeById(int id) async {
    return await revisionThemeDatabase.disableRevisionThemeById(id);
  }

  @override
  Future<List<RevisionTheme>> findAllRevisionTheme() async {
    return await revisionThemeDatabase.findAllRevisionTheme();
  }

  @override
  Future<List<RevisionTheme>?> findAllRevisionThemeSync() async {
    return await revisionThemeDatabase.findAllRevisionThemeSync();
  }

  @override
  Future<List<RevisionThemeComplement>> findRevisionThemeByDescription(String text) async {
    return await revisionThemeDatabase.findRevisionThemeByDescription(text);
  }

  @override
  Future<RevisionTheme?> findRevisionThemeById(int id) async {
    return await revisionThemeDatabase.findRevisionThemeById(id);
  }

  @override
  Future<RevisionTheme?> findRevisionThemeByIdExternal(int idExternal) async {
    return await revisionThemeDatabase.findRevisionThemeByIdExternal(idExternal);
  }

  @override
  Future<List<RevisionTheme>?> findRevisionThemeDisable() async {
    return await revisionThemeDatabase.findRevisionThemeDisable();
  }
}
