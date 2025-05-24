import 'package:planeje/database/app_database.dart';
import 'package:planeje/revision_theme/datasource/dao/revision_theme_info_dao.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/entities/revision_theme_complement.dart';

abstract class RevisionThemeDatabaseFactory {
  Future<List<RevisionTheme>> findAllRevisionTheme();
  Future<List<RevisionTheme>?> findAllRevisionThemeSync();
  Future<RevisionTheme?> findRevisionThemeById(int id);
  Future<RevisionTheme?> disableRevisionThemeById(int id);
  Future<List<RevisionThemeComplement>> findRevisionThemeByDescription(String text);
  Future<RevisionTheme?> findRevisionThemeByIdExternal(int idExternal);
  Future<int> insertRevisionTheme(RevisionTheme revisionTheme);
  Future<List<int>> insertRevisionThemeList(List<RevisionTheme> revisionThemes);
  Future<int?> updateRevisionTheme(RevisionTheme revisionTheme);
  Future<void> updateRevisionThemeList(List<RevisionTheme> revisionThemes);
}

class RevisionThemeDatabaseDataSource implements RevisionThemeDatabaseFactory {
  @override
  Future<RevisionTheme?> disableRevisionThemeById(int id) async {
    final database = await getInstance();
    return await database.revisionThemeDao.disableRevisionThemeById(id);
  }

  @override
  Future<List<RevisionTheme>> findAllRevisionTheme() async {
    final database = await getInstance();
    return await database.revisionThemeDao.findAllRevisionTheme();
  }

  @override
  Future<List<RevisionTheme>?> findAllRevisionThemeSync() async {
    final database = await getInstance();
    return await database.revisionThemeDao.findAllRevisionThemeSync();
  }

  @override
  Future<List<RevisionThemeComplement>> findRevisionThemeByDescription(String text) async {
    final database = await getInstance();
    return await RevisionThemeInfoDao().findRevisionThemeById(database, text);
  }

  @override
  Future<RevisionTheme?> findRevisionThemeById(int id) async {
    final database = await getInstance();
    return await database.revisionThemeDao.findRevisionThemeById(id);
  }

  @override
  Future<int> insertRevisionTheme(RevisionTheme revisionTheme) async {
    final database = await getInstance();
    return await database.revisionThemeDao.insertRevisionTheme(revisionTheme);
  }

  @override
  Future<List<int>> insertRevisionThemeList(List<RevisionTheme> revisionThemes) async {
    final database = await getInstance();
    return await database.revisionThemeDao.insertRevisionThemeList(revisionThemes);
  }

  @override
  Future<RevisionTheme?> findRevisionThemeByIdExternal(int idExternal) async {
    final database = await getInstance();
    return await database.revisionThemeDao.findRevisionThemeByIdExternal(idExternal);
  }

  @override
  Future<int?> updateRevisionTheme(RevisionTheme revisionTheme) async {
    final database = await getInstance();
    return await database.revisionThemeDao.updateRevisionTheme(revisionTheme);
  }

  @override
  Future<void> updateRevisionThemeList(List<RevisionTheme> revisionThemes) async {
    final database = await getInstance();
    return await database.revisionThemeDao.updateRevisionThemeList(revisionThemes);
  }
}
