abstract class DeleteFactory<T> {
  Future<void> deleteById(int id);
  Future<void> deleteByIdRevision(int id);
}
