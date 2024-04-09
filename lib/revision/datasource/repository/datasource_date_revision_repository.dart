import '../../entities/date_revision.dart';

abstract class DateRevisionDataSourceRepository {
  Future<List<DateRevision>> findAllDateRevisions();
  Future<DateRevision?> findDateRevisionById(int id);
  Future<DateRevision?> deleteDateRevisionById(int id);
  Future<int> insertDateRevision(DateRevision dateRevision);
  Future<int> updateDateRevision(DateRevision dateRevision);
}
