import 'package:flutter/material.dart';
import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/utils/register_category.dart';

import 'package:planeje/utils/app_bar/app_bar_navigation.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';

import '../../category/entities/category.dart';
import '../../category/pages/register_category/register_category.dart';

class CategoryAppBar implements IAppBarNavigatorAdd {
  CategoryAppBar({required this.onClick});
  Function() onClick;
  @override
  Widget buildAdd(BuildContext context) {
    return AddAppBarWidget(onClick: () => navigatorAdd(context));
  }

  @override
  Future<void> navigatorAdd(BuildContext context) async {
    var result = await Navigator.of(context).push(TransitionsBuilder.createRoute(RegisterCategoryPage(
      registerCategory: SaveCategory(
        CategoryDatabase(),
        Category(),
        StatusNotification(),
      ),
    )));

    if (result) onClick();
  }
}
