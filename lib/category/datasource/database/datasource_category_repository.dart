import 'package:planeje/category/entities/category.dart';
import 'package:planeje/database/app_database.dart';

abstract class CategoryDatabaseFactory {
  Future<List<Category>?> getAllCategory(String text);
  Future<int> insertCategory(Category category);
  Future<Category?> getCategoryId(int id);
  Future<int> updateCategory(Category category);
  Future<Category?> deleteCategoryById(int id);
}

class CategoryDatabase implements CategoryDatabaseFactory {
  @override
  Future<List<Category>?> getAllCategory(String text) async {
    final database = await getInstance();
    if (text != '') return await database.categoryDao.getCategory('%$text%');
    return await database.categoryDao.getAllCategory();
  }

  @override
  Future<Category?> getCategoryId(int id) async {
    final database = await getInstance();
    return await database.categoryDao.getCategoryId(id);
  }

  @override
  Future<int> insertCategory(Category category) async {
    final database = await getInstance();
    return await database.categoryDao.insertCategory(category);
  }

  @override
  Future<int> updateCategory(Category category) async {
    final database = await getInstance();
    return await database.categoryDao.updateCategory(category);
  }

  @override
  Future<Category?> deleteCategoryById(int id) async {
    final database = await getInstance();
    return await database.categoryDao.deleteCategoryById(id);
  }
}
