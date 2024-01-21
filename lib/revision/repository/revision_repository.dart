import '../entities/revision.dart';

abstract class RevisionRepository {
  Future<List<Revision>> findAllRevisions();
  Future<Revision?> findRevisionById(int id);
  Future<Revision?> deleteRevisionById(int id);
  Future<List<Revision>> findRevisionByDescription(String text);
  Future<void> updateRevision(String description, int id, bool status);
  Future<int?> insertRevision(Revision revision);
}
