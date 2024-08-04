import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/entities/category.dart';

abstract class IDeleteCategory {
  Future<Category?> deleteCategoryById(int id);
}

class DeleteCategory implements IDeleteCategory {
  DatasourceCategoryRepository datasourceCategoryRepository;

  DeleteCategory(this.datasourceCategoryRepository);

  @override
  Future<Category?> deleteCategoryById(int id) async {
    return await datasourceCategoryRepository.deleteCategoryById(id);
  }
}
