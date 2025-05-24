abstract class DeleteFactory<T> {
  Future<void> disableById(int id);
  Future<void> disableByIdRevision(int id);
}
