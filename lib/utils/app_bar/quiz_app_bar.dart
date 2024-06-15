import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';
import 'package:planeje/quiz_revision/pages/list_quiz/page/list_quiz.dart';
import 'package:planeje/quiz_revision/pages/register_quiz/page/register_quiz_page.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/register_quiz.dart';
import 'package:planeje/utils/app_bar/app_bar_navigation.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';
import 'package:planeje/widgets/app_bar_widget/app_bar_button_widget.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/widgets/app_bar_widget/search_app_bar_widget.dart';

class QuizAppBar implements IAppBarNavigator, IAppBarNavigatorAdd, IAppBarSearch {
  QuizAppBar({required this.onClick, this.color});

  Function() onClick;

  @override
  void navigator(BuildContext context) {
    Navigator.of(context).push(TransitionsBuilder.createRoute(const ListQuiz()));
  }

  @override
  Widget build(BuildContext context) {
    return AppBarButtonWidget(onClick: () => navigator(context), title: 'Quiz', color: color);
  }

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

  @override
  Color? color;

  @override
  Widget buildIcon(BuildContext context) {
    return SearchAppBarWidget(onClick: onClick);
  }
}
