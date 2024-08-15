import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/utils/type_message.dart';

import '../entities/category.dart';

abstract class RegisterCategory {
  Future<int?> writeCategory();
  late Category category;
  late StatusNotification message;
}

class SaveCategory implements RegisterCategory {
  DatasourceCategoryRepository datasourceCategoryRepository;
  SaveCategory(this.datasourceCategoryRepository, this.category, this.message);

  @override
  Future<int?> writeCategory() async {
    return await datasourceCategoryRepository.insertCategory(category);
  }

  @override
  Category category;

  @override
  StatusNotification message;
}

class UpdateCategory implements RegisterCategory {
  DatasourceCategoryRepository datasourceCategoryRepository;
  UpdateCategory(this.datasourceCategoryRepository, this.category, this.message);

  @override
  Future<int?> writeCategory() async {
    return await datasourceCategoryRepository.updateCategory(category);
  }

  @override
  Category category;

  @override
  StatusNotification message;
}
