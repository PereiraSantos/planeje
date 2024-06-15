import 'package:flutter/material.dart';
import 'package:planeje/dashboard/utils/find_revision.dart';
import 'package:planeje/dashboard/utils/next_revision_time.dart';
import 'package:planeje/dashboard/controller/reviser_notifier.dart';
import 'package:planeje/dashboard/utils/valid_date.dart';
import 'package:planeje/utils/app_bar/annotation_app_bar.dart';
import 'package:planeje/utils/app_bar/home_app_bar.dart';
import 'package:planeje/utils/app_bar/quiz_app_bar.dart';
import 'package:planeje/utils/app_bar/revision_app_bar.dart';
import '../../widgets/app_bar_widget/app_bar_widget.dart';
import '../component/next_revision.dart';
import '../component/reviser_late.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void reloadPage() => setState(() {});

  final ReviserNotifier reviserNotifier = ReviserNotifier();

  @override
  void initState() {
    super.initState();

    GetDelayedRevision(ValidateIsBefore(), reviserNotifier).getRevision();
    GetCompletedRevision(ValidateIsAfter(), reviserNotifier).getRevision();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: ListenableBuilder(
          listenable: reviserNotifier,
          builder: (BuildContext context, Widget? child) {
            return AppBarWidget(
              actions: [HomeAppBar(quantity: reviserNotifier.quantityDelayed).buildNotification(context)],
              child: [
                HomeAppBar(quantity: reviserNotifier.quantityDelayed, color: Colors.black54).build(context),
                RevisionAppBar(onClick: reloadPage).build(context),
                AnnotationAppBar(onClick: reloadPage).build(context),
                QuizAppBar(onClick: reloadPage).build(context),
              ],
            );
          },
        ),
      ),
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: reviserNotifier,
          builder: (BuildContext context, Widget? child) {
            return Column(
              children: [
                ReviserLate(
                    quantityCompleted: reviserNotifier.quantityCompleted,
                    quantityDelayed: reviserNotifier.quantityDelayed),
                NextRevision(
                    future: NetRevisionTime(ValidateIsBefore()).getNextRevision(),
                    text: 'Próxima revisão atrasada',
                    finishUpdaterReviser: () => reloadPage()),
                NextRevision(
                  future: NetRevisionTime(ValidateIsAfter()).getNextRevision(),
                  text: 'Próxima revisão',
                  finishUpdaterReviser: () => reloadPage(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
