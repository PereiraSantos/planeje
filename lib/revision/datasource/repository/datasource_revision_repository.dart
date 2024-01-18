import '../../../entities/revision.dart';

abstract class IDataSourceRevisionRepository {
  Future<List<Revision>> findAllRevisions();
  Future<Revision?> findRevisionById(int id);
  Future<Revision?> deleteRevisionById(int id);
  Future<List<Revision>> findRevisionByDescription(String text);
  Future<int?> updateRevision(String description, int id, bool status);
  Future<int?> insertRevision(Revision revision);
}
