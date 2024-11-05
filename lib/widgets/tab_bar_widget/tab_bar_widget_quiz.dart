import 'package:flutter/material.dart';
import 'package:planeje/dashboard/pages/home.dart';
import 'package:planeje/quiz_revision/pages/list_quiz/page/list_quiz.dart';
import 'package:planeje/utils/app_bar/quiz_app_bar.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/widgets/app_bar_widget/app_bar_button_widget.dart';
import 'package:planeje/widgets/app_bar_widget/home_app_bar_widget.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_widget.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

class TabBarWidgetQuiz extends StatefulWidget {
  const TabBarWidgetQuiz({super.key});

  @override
  State<TabBarWidgetQuiz> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidgetQuiz> with SingleTickerProviderStateMixin {
  final TabBarNotifier tabBarNotifier = TabBarNotifier();

  dynamic notifier;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: ListenableBuilder(
          listenable: tabBarNotifier.searchNotifier,
          builder: (BuildContext context, Widget? child) {
            return Row(
              children: [
                HomeAppBarWidget(
                  onClick: () async =>
                      await Navigator.of(context).push(TransitionsBuilder.createRoute(Home())),
                ),
                if (tabBarNotifier.searchNotifier.hideSearch) ...[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 30,
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormFieldWidget(
                        controller: TextEditingController(),
                        hintText: 'Pesquisar',
                        valid: false,
                        autofocus: false,
                        borderRadius: 15,
                        padding: const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 3.5),
                        fontSize: 15,
                        onChange: (value) => notifier.setSearch(value)),
                  )
                ],
                if (!tabBarNotifier.searchNotifier.hideSearch) ...[
                  AppBarButtonWidget(
                    onClick: () async => await Navigator.of(context)
                        .push(TransitionsBuilder.createRoute(const TabBarWidget())),
                    title: 'Assunto',
                  ),
                  AppBarButtonWidget(
                    value: 0.2,
                    onClick: () async => await Navigator.of(context)
                        .push(TransitionsBuilder.createRoute(const TabBarWidgetQuiz())),
                    title: 'Quiz',
                    color: Colors.black54,
                  ),
                ]
              ],
            );
          },
        ),
        actions: [
          ListenableBuilder(
            listenable: tabBarNotifier.searchNotifier,
            builder: (BuildContext context, Widget? child) {
              return tabBarNotifier.searchNotifier.hideSearch
                  ? IconButton(
                      onPressed: () => tabBarNotifier.searchNotifier.updateHideSearch(false),
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 22,
                        ),
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: IconButton(
                        onPressed: () => tabBarNotifier.searchNotifier.updateHideSearch(true),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black54,
                          size: 22,
                        ),
                      ),
                    );
            },
          ),
          ListenableBuilder(
            listenable: tabBarNotifier,
            builder: (BuildContext context, Widget? child) {
              notifier = tabBarNotifier.quizNotifier;
              return QuizAppBar(onClick: () => tabBarNotifier.quizNotifier.update()).buildAdd(context);
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: tabBarNotifier.quizNotifier,
        builder: (BuildContext context, Widget? child) => ListQuiz(tabBarNotifier.quizNotifier),
      ),
    );
  }
}
