abstract class FindFactory<T> {
  Future<List<T>?> getAll(String text);
  Future<T?> getById(int id);
}
