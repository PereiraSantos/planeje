import 'package:flutter/material.dart';
import 'package:planeje/suggestion/datasource/database/suggestion_database.dart';
import 'package:planeje/suggestion/entities/suggestion.dart';
import 'package:planeje/suggestion/pages/register_suggestion/page/register_suggestion.dart';
import 'package:planeje/suggestion/utils/register_suggestion.dart';

import 'package:planeje/utils/app_bar/app_bar_navigation.dart';
import 'package:planeje/utils/type_message.dart';

import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';

import 'package:planeje/utils/transitions_builder.dart';

class SuggestionAppBar implements IAppBarNavigatorAdd {
  SuggestionAppBar({required this.onClick});

  Function() onClick;

  @override
  Widget buildAdd(BuildContext context) {
    return AddAppBarWidget(onClick: () => navigatorAdd(context));
  }

  @override
  Future<void> navigatorAdd(BuildContext context) async {
    var result = await Navigator.of(context).push(
      TransitionsBuilder.createRoute(
        RegisterSuggestion(
          registerSuggestion: InsertSuggestion(
            SuggestionDatabaseDataSource(),
            StatusNotification(),
            Suggestion(),
          ),
        ),
      ),
    );

    if (result) onClick();
  }
}
