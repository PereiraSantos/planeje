import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';

import 'package:planeje/annotation/pages/register_annotation/pages/register_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/utils/app_bar/app_bar_navigation.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';

import 'package:planeje/utils/transitions_builder.dart';

class AnnotationAppBar implements IAppBarNavigatorAdd {
  AnnotationAppBar({required this.onClick});

  Function() onClick;

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
            StatusNotification(),
          ),
        ),
      ),
    );

    if (result) onClick();
  }
}
