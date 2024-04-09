import '../../entities/revision.dart';
import '../../entities/revision_time.dart';

abstract class RevisionDataSourceRepository {
  Future<List<Revision>> findAllRevisions();
  Future<Revision?> findRevisionById(int id);
  Future<Revision?> deleteRevisionById(int id);
  Future<List<RevisionTime>> findRevisionByDescription(String text);
  Future<int?> updateRevision(Revision revision);
  Future<int?> insertRevision(Revision revision);
}
