import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/pages/list_annotation/page/list_annotation.dart';
import 'package:planeje/annotation/pages/register_annotation/pages/register_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/utils/app_bar/app_bar_navigation.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';
import 'package:planeje/widgets/app_bar_widget/app_bar_button_widget.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/widgets/app_bar_widget/search_app_bar_widget.dart';

class AnnotationAppBar implements IAppBarNavigator, IAppBarNavigatorAdd, IAppBarSearch {
  AnnotationAppBar({required this.onClick, this.color});

  Function() onClick;

  @override
  void navigator(BuildContext context) {
    Navigator.of(context).push(TransitionsBuilder.createRoute(const ListAnnotation()));
  }

  @override
  Widget build(BuildContext context) {
    return AppBarButtonWidget(onClick: () => navigator(context), title: 'Anotação', color: color);
  }

  @override
  Widget buildAdd(BuildContext context) {
    return AddAppBarWidget(onClick: () => navigatorAdd(context));
  }

  @override
  Future<void> navigatorAdd(BuildContext context) async {
    var result = await Navigator.of(context).push(
      TransitionsBuilder.createRoute(
        RegisterAnnotation(
          registerAnnotation: InsertAnnotation(
            AnnotationDatabaseDatasource(),
            Annotation(),
            Message(),
          ),
        ),
      ),
    );

    if (result) onClick();
  }

  @override
  Color? color;

  @override
  Widget buildIcon(BuildContext context) {
    return SearchAppBarWidget(onClick: onClick);
  }
}
