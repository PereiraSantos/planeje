import 'package:flutter/material.dart';
import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/learn/pages/register_learn/register_learn.dart';
import 'package:planeje/learn/utils/register_learn.dart';
import 'package:planeje/utils/app_bar/app_bar_navigation.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';
import 'package:planeje/utils/transitions_builder.dart';

class LearnAppBar implements IAppBarNavigatorAdd {
  LearnAppBar({required this.onClick});

  Function() onClick;

  @override
  Widget buildAdd(BuildContext context) {
    return AddAppBarWidget(onClick: () => navigatorAdd(context));
  }

  @override
  Future<void> navigatorAdd(BuildContext context) async {
    var result = await Navigator.of(context).push(
      TransitionsBuilder.createRoute(
        RegisterLearnPage(registerLearn: SaveLearn(LearnDatabase(), Learn(), Message())),
      ),
    );

    if (result) onClick();
  }
}
