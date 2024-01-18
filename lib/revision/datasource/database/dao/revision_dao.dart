import 'package:floor/floor.dart';
import 'package:planeje/entities/revision.dart';

@dao
abstract class RevisionDao {
  @Query('SELECT * FROM revision')
  Future<List<Revision>> findAllRevisions();

  @Query('SELECT * FROM revision WHERE id = :id')
  Future<Revision?> findRevisionById(int id);

  @Query('delete FROM revision WHERE id = :id')
  Future<Revision?> deleteRevisionById(int id);

  @Query('SELECT * FROM revision WHERE text LIKE :text')
  Future<List<Revision>> findRevisionByDescription(String text);

  @Query('update revision set text = :text,  description = :description, status = :status WHERE id = :id')
  Future<void> updateRevision(String text, String description, int id, bool status);

  @insert
  Future<int> insertRevision(Revision revision);
}
