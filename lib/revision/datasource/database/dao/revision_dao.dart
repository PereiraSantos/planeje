import 'package:floor/floor.dart';

import '../../../entities/revision.dart';

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

  @Query(
      'update revision set description = :description, next_date = :nextDate,status = :status WHERE id = :id')
  Future<int?> updateRevision(String description, String nextDate, int id, bool status);

  @Query('SELECT * FROM revision where status = 0 order by next_date desc limit 3')
  Future<List<Revision>?> getNextRevisionLate();

  @Query('SELECT * FROM revision where status = 1 order by next_date desc limit 3')
  Future<List<Revision>?> getNextRevision();

  @Query('SELECT * FROM revision where status = 0')
  Future<List<Revision>?> getDelayedRevision();

  @Query('SELECT * FROM revision where status = 1')
  Future<List<Revision>?> getCompletedRevision();

  @insert
  Future<int> insertRevision(Revision revision);
}
