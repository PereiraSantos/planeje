import 'package:flutter/material.dart';
import 'package:planeje/dashboard/pages/dashboard.dart';
import 'package:planeje/dashboard/utils/check_setting.dart';
import 'package:planeje/dashboard/utils/find_revision.dart';
import 'package:planeje/dashboard/controller/reviser_notifier.dart';
import 'package:planeje/quiz_revision/pages/list_quiz/page/list_quiz.dart';
import 'package:planeje/revision/pages/list_revision/page/list_revision.dart';
import 'package:planeje/settings/pages/setting_page.dart';

class Home extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void reloadPage() => setState(() {});

  final ReviserNotifier reviserNotifier = ReviserNotifier();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screen = [
    Dashboard(),
    ListRevision(),
    ListQuiz(),
    SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
    CheckSetting().checkRealize();
    CheckSetting().checkNext();

    GetDelayedRevision(reviserNotifier).getRevision();
    GetCompletedRevision(reviserNotifier).getRevision();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      /*  appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: ListenableBuilder(
          listenable: reviserNotifier,
          builder: (BuildContext context, Widget? child) {
            return AppBarWidget(
              actions: [
                NotificationAppBarWidget(quantity: reviserNotifier.quantityReviserDelayed),
                SettingAppBarWidget(
                  onClick: () async {
                    var result = await Navigator.of(context).push(TransitionsBuilder.createRoute(SettingPage()));
                    if (result != null && result) reloadPage();
                  },
                ),
              ],
              child: [
                HomeAppBarWidget(onClick: () => null, color: Colors.black54),
                AppBarButtonWidget(
                    onClick: () async => await Navigator.of(context).push(TransitionsBuilder.createRoute(const TabBarWidget())), title: 'Revisão'),
                AppBarButtonWidget(
                    value: 0.2, onClick: () async => await Navigator.of(context).push(TransitionsBuilder.createRoute(const TabBarWidgetQuiz())), title: 'Quiz'),
              ],
            );
          },
        ),
      ),*/
      body: _screen[_selectedIndex],
      /* body: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: reviserNotifier,
          builder: (BuildContext context, Widget? child) {
            return Column(
              children: [
                ReviserLate(
                  quantityCompleted: reviserNotifier.quantityReviserCompleted,
                  quantityDelayed: reviserNotifier.quantityReviserDelayed,
                ),
                ListenableBuilder(
                  listenable: underReviewNotifier,
                  builder: (BuildContext context, Widget? child) {
                    return UnderReview(
                      underReviewNotifier: underReviewNotifier,
                      finishReviser: () => reloadPage(),
                    );
                  },
                ),
                NextRevision(
                  future: NetRevisionTime(false).getNextRevision('realize'),
                  text: 'Realizar',
                  finishUpdaterReviser: () => reloadPage(),
                  underReviewNotifier: underReviewNotifier,
                ),
                NextRevision(
                  future: NetRevisionTime(true).getNextRevision('next'),
                  text: 'Próximas',
                  finishUpdaterReviser: () => reloadPage(),
                  underReviewNotifier: underReviewNotifier,
                ),
              ],
            );
          },
        ),
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Revisão',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ballot),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuração',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
