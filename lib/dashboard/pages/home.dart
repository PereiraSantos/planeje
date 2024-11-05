import 'package:flutter/material.dart';
import 'package:planeje/dashboard/component/under_review.dart';
import 'package:planeje/dashboard/controller/under_review_notifier.dart';
import 'package:planeje/dashboard/utils/check_setting.dart';
import 'package:planeje/dashboard/utils/find_revision.dart';
import 'package:planeje/dashboard/utils/next_revision_time.dart';
import 'package:planeje/dashboard/controller/reviser_notifier.dart';
import 'package:planeje/settings/pages/setting_page.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/widgets/app_bar_widget/app_bar_button_widget.dart';
import 'package:planeje/widgets/app_bar_widget/app_bar_widget.dart';
import 'package:planeje/widgets/app_bar_widget/home_app_bar_widget.dart';
import 'package:planeje/widgets/app_bar_widget/notification_app_bar_widget.dart';
import 'package:planeje/widgets/app_bar_widget/setting_app_bar_widget.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_widget.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_widget_quiz.dart';
import '../component/next_revision.dart';
import '../component/reviser_late.dart';

class Home extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void reloadPage() => setState(() {});

  final ReviserNotifier reviserNotifier = ReviserNotifier();
  final UnderReviewNotifier underReviewNotifier = UnderReviewNotifier();

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: ListenableBuilder(
          listenable: reviserNotifier,
          builder: (BuildContext context, Widget? child) {
            return AppBarWidget(
              actions: [
                NotificationAppBarWidget(quantity: reviserNotifier.quantityReviserDelayed),
                SettingAppBarWidget(
                  onClick: () async {
                    var result =
                        await Navigator.of(context).push(TransitionsBuilder.createRoute(SettingPage()));
                    if (result != null && result) reloadPage();
                  },
                ),
              ],
              child: [
                HomeAppBarWidget(onClick: () => null, color: Colors.black54),
                AppBarButtonWidget(
                    onClick: () async => await Navigator.of(context)
                        .push(TransitionsBuilder.createRoute(const TabBarWidget())),
                    title: 'Revisão'),
                AppBarButtonWidget(
                    value: 0.2,
                    onClick: () async => await Navigator.of(context)
                        .push(TransitionsBuilder.createRoute(const TabBarWidgetQuiz())),
                    title: 'Quiz'),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
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
      ),
    );
  }
}
