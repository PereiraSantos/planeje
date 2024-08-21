import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/utils/register.dart';
import 'package:planeje/utils/type_message.dart';

import '../entities/category.dart';

abstract class RegisterCategoryFactory extends RegisterFactory {
  late Category category;
}

class SaveCategory implements RegisterCategoryFactory {
  CategoryDatabaseFactory categoryDatabase;
  SaveCategory(this.categoryDatabase, this.category, this.message);

  @override
  Future<int?> write() async {
    return await categoryDatabase.insertCategory(category);
  }

  @override
  Category category;

  @override
  Message message;
}

class UpdateCategory implements RegisterCategoryFactory {
  CategoryDatabaseFactory categoryDatabase;
  UpdateCategory(this.categoryDatabase, this.category, this.message);

  @override
  Future<int?> write() async {
    return await categoryDatabase.updateCategory(category);
  }

  @override
  Category category;

  @override
  Message message;
}
