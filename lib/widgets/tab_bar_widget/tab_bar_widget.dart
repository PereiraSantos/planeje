import 'package:flutter/material.dart';
import 'package:planeje/annotation/pages/list_annotation/page/list_annotation.dart';
import 'package:planeje/category/pages/list_category/list_category.dart';
import 'package:planeje/dashboard/pages/home.dart';
import 'package:planeje/learn/pages/list_learn/page/list_learn.dart';
import 'package:planeje/quiz_revision/pages/list_quiz/page/list_quiz.dart';
import 'package:planeje/revision/pages/list_revision/page/list_revision.dart';
import 'package:planeje/utils/app_bar/annotation_app_bar.dart';
import 'package:planeje/utils/app_bar/category_app_bar.dart';
import 'package:planeje/utils/app_bar/learn_app_bar.dart';
import 'package:planeje/utils/app_bar/quiz_app_bar.dart';
import 'package:planeje/utils/app_bar/revision_app_bar.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/widgets/app_bar_widget/app_bar_button_widget.dart';
import 'package:planeje/widgets/app_bar_widget/home_app_bar_widget.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  final TabBarNotifier tabBarNotifier = TabBarNotifier();

  dynamic notifier;

  static const List<Tab> tabs = <Tab>[
    Tab(child: Text('Conhecimento', style: TextStyle(color: Colors.grey, fontSize: 16))),
    Tab(child: Text('Revisão', style: TextStyle(color: Colors.grey, fontSize: 16))),
    Tab(child: Text('Categoria', style: TextStyle(color: Colors.grey, fontSize: 16))),
    Tab(child: Text('Anotação', style: TextStyle(color: Colors.grey, fontSize: 16))),
    Tab(child: Text('Quiz', style: TextStyle(color: Colors.grey, fontSize: 16))),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        tabBarNotifier.searchNotifier.updateHideSearch(false);
        tabBarNotifier.update();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
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
                      title: 'Cronograma',
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
                if (_tabController.index == 0) {
                  notifier = tabBarNotifier.learnNotifier;
                  return LearnAppBar(onClick: () => tabBarNotifier.learnNotifier.update()).buildAdd(context);
                }
                if (_tabController.index == 1) {
                  notifier = tabBarNotifier.revisionNotifier;
                  return RevisionAppBar(onClick: () => tabBarNotifier.revisionNotifier.update())
                      .buildAdd(context);
                }
                if (_tabController.index == 2) {
                  notifier = tabBarNotifier.categoryNotifier;
                  return CategoryAppBar(onClick: () => tabBarNotifier.categoryNotifier.update())
                      .buildAdd(context);
                }
                if (_tabController.index == 3) {
                  notifier = tabBarNotifier.annotationNotifier;
                  return AnnotationAppBar(onClick: () => tabBarNotifier.annotationNotifier.update())
                      .buildAdd(context);
                }
                if (_tabController.index == 4) {
                  notifier = tabBarNotifier.quizNotifier;
                  return QuizAppBar(onClick: () => tabBarNotifier.quizNotifier.update()).buildAdd(context);
                }
                return const SizedBox();
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.grey,
            indicatorWeight: 2,
            isScrollable: true,
            padding: const EdgeInsets.only(left: 10, right: 10),
            controller: _tabController,
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListenableBuilder(
                listenable: tabBarNotifier.learnNotifier,
                builder: (BuildContext context, Widget? child) => ListLearn(tabBarNotifier.learnNotifier)),
            ListenableBuilder(
              listenable: tabBarNotifier.revisionNotifier,
              builder: (BuildContext context, Widget? child) => ListRevision(tabBarNotifier.revisionNotifier),
            ),
            ListenableBuilder(
                listenable: tabBarNotifier.categoryNotifier,
                builder: (BuildContext context, Widget? child) =>
                    ListCategory(tabBarNotifier.categoryNotifier)),
            ListenableBuilder(
                listenable: tabBarNotifier.annotationNotifier,
                builder: (BuildContext context, Widget? child) =>
                    ListAnnotation(tabBarNotifier.annotationNotifier)),
            ListenableBuilder(
              listenable: tabBarNotifier.quizNotifier,
              builder: (BuildContext context, Widget? child) => ListQuiz(tabBarNotifier.quizNotifier),
            ),
          ],
        ),
      ),
    );
  }
}
