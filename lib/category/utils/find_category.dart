import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/entities/category.dart';

abstract class FindCategoryFactory {
  Future<List<Category>?> getAllCategory(String text);
  Future<Category?> getCategoryId(int id);
}

class GetCategory implements FindCategoryFactory {
  CategoryDatabaseFactory categoryDatabase;

  GetCategory(this.categoryDatabase);

  @override
  Future<List<Category>?> getAllCategory(String text) async {
    return await categoryDatabase.getAllCategory(text);
  }

  @override
  Future<Category?> getCategoryId(int id) async {
    return await categoryDatabase.getCategoryId(id);
  }
}
