import 'package:floor/floor.dart';
import 'package:planeje/revision/entities/date_revision.dart';

@dao
abstract class DateRevisionDao {
  @Query('SELECT * FROM date_revision')
  Future<List<DateRevision>> findAllRevisions();

  @Query('SELECT * FROM date_revision where sync = 0')
  Future<List<DateRevision>?> findAllDateRevisionSync();

  @Query('delete FROM date_revision WHERE id = :id')
  Future<DateRevision?> deleteDateRevisionById(int id);

  @Query('delete FROM date_revision WHERE id_revision = :idRevision')
  Future<DateRevision?> deleteDateRevisionByIdRevision(int idRevision);

  @update
  Future<int?> updateDateRevision(DateRevision dateRevision);

  @insert
  Future<int?> insertDateRevision(DateRevision dateRevision);

  @insert
  Future<List<int>> insertDateRevisionList(List<DateRevision> dateRevision);

  @Query('update date_revision set hour_init = :hourInit where id_date = :id')
  Future<void> updateHourInitRevision(String hourInit, int id);

  @Query('update date_revision set date_revision = :dateRevision, next_date_revision = :nextDateRevision, hour_end = :hourEnd where id_date = :id')
  Future<void> updateHourEndRevision(String hourEnd, String dateRevision, String nextDateRevision, int id);

  @Query('update date_revision set status = :status where id_date = :id')
  Future<void> updateStatus(bool status, int id);

  @Query(' select * from date_revision  where id_date = :id')
  Future<DateRevision?> findDateRevisionById(int id);

  @Query('select count(*) from date_revision where id_date = :id')
  Future<int?> isRegistration(int id);

  @update
  Future<void> updateDateRevisionList(List<DateRevision> dateRevision);
}
