import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';
import 'package:planeje/quiz_revision/pages/register_quiz/page/register_quiz_page.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/register_quiz.dart';
import 'package:planeje/utils/app_bar/app_bar_navigation.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';

import 'package:planeje/utils/transitions_builder.dart';

class QuizAppBar implements IAppBarNavigatorAdd {
  QuizAppBar({required this.onClick});

  Function() onClick;

  @override
  Widget buildAdd(BuildContext context) {
    return AddAppBarWidget(onClick: () => navigatorAdd(context));
  }

  @override
  Future<void> navigatorAdd(BuildContext context) async {
    var result = await Navigator.of(context).push(
      TransitionsBuilder.createRoute(
        RegisterQuizPage(
          registerQuiz: SaveQuiz(QuizDatabase(), Quiz(), Message()),
        ),
      ),
    );

    if (result) onClick();
  }
}
