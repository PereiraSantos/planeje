import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/entities/category.dart';

abstract class DeleteCategoryFactory {
  Future<Category?> deleteCategoryById(int id);
}

class DeleteCategory implements DeleteCategoryFactory {
  CategoryDatabaseFactory categoryDatabase;

  DeleteCategory(this.categoryDatabase);

  @override
  Future<Category?> deleteCategoryById(int id) async {
    return await categoryDatabase.deleteCategoryById(id);
  }
}
