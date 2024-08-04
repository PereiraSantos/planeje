import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/entities/category.dart';

abstract class IFindCategory {
  Future<List<Category>?> getAllCategory(String text);
  Future<Category?> getCategoryId(int id);
}

class GetCategory implements IFindCategory {
  DatasourceCategoryRepository datasourceCategoryRepository;

  GetCategory(this.datasourceCategoryRepository);

  @override
  Future<List<Category>?> getAllCategory(String text) async {
    return await datasourceCategoryRepository.getAllCategory(text);
  }

  @override
  Future<Category?> getCategoryId(int id) async {
    return await datasourceCategoryRepository.getCategoryId(id);
  }
}
