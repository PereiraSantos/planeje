import 'package:floor/floor.dart';
import 'package:planeje/category/entities/category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM category')
  Future<List<Category>?> getAllCategory();

  @Query('SELECT * FROM category where description LIKE :text')
  Future<List<Category>?> getCategory(String text);

  @insert
  Future<int> insertCategory(Category category);

  @Query('SELECT * FROM category WHERE id = :id')
  Future<Category?> getCategoryId(int id);

  @Query('delete FROM category WHERE id = :id')
  Future<Category?> deleteCategoryById(int id);

  @update
  Future<int> updateCategory(Category category);
}
