import '../../entities/date_revision.dart';

abstract class IDateRevisionRepository {
  Future<List<DateRevision>> findAllDateRevisions();
  Future<List<DateRevision>> findDateRevisionById(int id);
  Future<DateRevision?> findDateRevisionByIdRevision(int id, String date);
  Future<DateRevision?> deleteDateRevisionById(int id);
  Future<DateRevision?> deleteDateRevisionByIdRevision(int id, String date);
  Future<DateRevision?> updateDateRevisionById(bool status, int id);
  Future<void> insertDateRevision(DateRevision dateRevision);
  Future<void> insertDateRevisionList(List<DateRevision> dateRevision);
}
