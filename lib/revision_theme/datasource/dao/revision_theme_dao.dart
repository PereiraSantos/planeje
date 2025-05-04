import 'package:floor/floor.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';

@dao
abstract class RevisionThemeDao {
  @Query('SELECT * FROM revision_theme')
  Future<List<RevisionTheme>> findAllRevisionTheme();

  @Query('SELECT * FROM revision_theme where sync = 0')
  Future<List<RevisionTheme>?> findAllRevisionThemeSync();

  @Query('SELECT * FROM revision_theme WHERE id = :id')
  Future<RevisionTheme?> findRevisionThemeById(int id);

  @Query('delete FROM revision_theme WHERE id = :id')
  Future<RevisionTheme?> deleteRevisionThemeById(int id);

  @Query('SELECT * FROM revision_theme WHERE description LIKE :text')
  Future<List<RevisionTheme>> findRevisionThemeByDescription(String text);

  @Query('select count(*) from revision_theme where id  = :id')
  Future<int?> isRegistration(int id);

  @insert
  Future<int> insertRevisionTheme(RevisionTheme revisionTheme);

  @insert
  Future<List<int>> insertRevisionThemeList(List<RevisionTheme> revisionThemes);

  @update
  Future<int?> updateRevisionTheme(RevisionTheme revisionTheme);

  @update
  Future<void> updateRevisionThemeList(List<RevisionTheme> revisionThemes);
}
