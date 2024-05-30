import 'package:floor/floor.dart';
import 'package:planeje/revision/entities/date_revision.dart';

@dao
abstract class DateRevisionDao {
  @Query('SELECT * FROM date_revision')
  Future<List<DateRevision>> findAllRevisions();

  @Query('SELECT * FROM date_revision WHERE id = :id')
  Future<DateRevision?> findDateRevisionById(int id);

  @Query('delete FROM date_revision WHERE id = :id')
  Future<DateRevision?> deleteDateRevisionById(int id);

  @update
  Future<int> updateDateRevision(DateRevision dateRevision);

  @insert
  Future<int> insertDateRevision(DateRevision dateRevision);
}
