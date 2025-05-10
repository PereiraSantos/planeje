import 'package:floor/floor.dart';
import 'package:planeje/revision/entities/revision.dart';

@dao
abstract class RevisionDao {
  @Query('SELECT * FROM revision')
  Future<List<Revision>> findAllRevisions();

  @Query('SELECT * FROM revision where sync = 0')
  Future<List<Revision>?> findAllRevisionsSync();

  @Query('SELECT * FROM revision WHERE id = :id')
  Future<Revision?> findRevisionById(int id);

  @Query('delete FROM revision WHERE id = :id')
  Future<Revision?> deleteRevisionById(int id);

  @Query('SELECT * FROM revision WHERE text LIKE :text')
  Future<List<Revision>> findRevisionByDescription(String text);

  @Query('SELECT * FROM revision where id_revision_theme = :idRevisionTheme')
  Future<List<Revision>?> findRevisioByIdRevisionTheme(int idRevisionTheme);

  @Query('select count(*) from revision where id_external  = :idExternal')
  Future<int?> isRegistration(int idExternal);

  @insert
  Future<int> insertRevision(Revision revision);

  @insert
  Future<List<int>> insertRevisionList(List<Revision> revision);

  @update
  Future<int?> updateRevision(Revision revision);

  @update
  Future<void> updateRevisionList(List<Revision> revision);
}
