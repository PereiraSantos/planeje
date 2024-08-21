import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/entities/category.dart';
import 'package:planeje/utils/find.dart';

abstract class FindCategoryFactory extends FindFactory {}

class GetCategory implements FindCategoryFactory {
  CategoryDatabaseFactory categoryDatabase;

  GetCategory(this.categoryDatabase);

  @override
  Future<List<Category>?> getAll(String text) async {
    return await categoryDatabase.getAllCategory(text);
  }

  @override
  Future<Category?> getById(int id) async {
    return await categoryDatabase.getCategoryId(id);
  }
}
