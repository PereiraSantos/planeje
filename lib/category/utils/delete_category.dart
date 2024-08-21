import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/entities/category.dart';
import 'package:planeje/utils/delete.dart';

abstract class DeleteCategoryFactory extends DeleteFactory {}

class DeleteCategory implements DeleteCategoryFactory {
  CategoryDatabaseFactory categoryDatabase;

  DeleteCategory(this.categoryDatabase);

  @override
  Future<Category?> deleteById(int id) async {
    return await categoryDatabase.deleteCategoryById(id);
  }
}
