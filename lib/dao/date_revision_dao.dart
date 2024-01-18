import 'package:floor/floor.dart';
import 'package:planeje/entities/date_revision.dart';

@dao
abstract class DateRevisionDao {
  @Query('SELECT * FROM date_revision')
  Future<List<DateRevision>> findAllDateRevisions();

  @Query('SELECT * FROM date_revision WHERE revision_id = :id order by date asc')
  Future<List<DateRevision>> findDateRevisionById(int id);

  @Query('SELECT * FROM date_revision WHERE revision_id = :id and date = :date')
  Future<DateRevision?> findDateRevisionByIdRevision(int id, String date);

  @Query('delete FROM date_revision WHERE revision_id = :id')
  Future<DateRevision?> deleteDateRevisionById(int id);

  @Query('delete FROM date_revision WHERE revision_id = :id and date = :date')
  Future<DateRevision?> deleteDateRevisionByIdRevision(int id, String date);

  @Query('update  date_revision set status = :status WHERE id = :id')
  Future<DateRevision?> updateDateRevisionById(bool status, int id);

  @insert
  Future<int> insertDateRevision(DateRevision dateRevision);

  @insert
  Future<void> insertDateRevisionList(List<DateRevision> dateRevision);
}
