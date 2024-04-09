import 'package:flutter/material.dart';
import 'package:planeje/annotation/pages/list_annotation/pages/list_annotation.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision.dart';

import '../../revision/pages/list_revision/page/list_revision.dart';
import '../../usercase/transitions_builder.dart';
import '../../widgets/app_bar_widget.dart';
import '../component/charts_revision/charts_revision.dart';
import '../component/hour_revision.dart';
import '../component/next_revision.dart';
import '../component/reviser_late.dart';
import '../controller/dashboard_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void reloadPage() => setState(() {});

  final DashboardController dashboardController = DashboardController();

  @override
  void initState() {
    super.initState();
    dashboardController.getDelayedRevision();
    dashboardController.getCompletedRevision();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: ListenableBuilder(
          listenable: dashboardController.reviserNotifier,
          builder: (BuildContext context, Widget? child) {
            return AppBarWidget(
              callbackHome: () => Navigator.of(context).push(TransitionsBuilder.createRoute(const Home())),
              callbackReviser: () =>
                  Navigator.of(context).push(TransitionsBuilder.createRoute(const ListRevision())),
              callbackAnnotation: () =>
                  Navigator.of(context).push(TransitionsBuilder.createRoute(const ListAnnotation())),
              callbackAdd: () async {
                var result = await Navigator.of(context).push(
                  TransitionsBuilder.createRoute(
                    RegisterRevision(),
                  ),
                );

                if (result) reloadPage();
              },
              callbackFilter: () {
                reloadPage();
              },
              colorHome: Colors.black54,
              showAction: false,
              quantity: dashboardController.reviserNotifier.quantityDelayed,
            );
          },
        ),
      ),
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: dashboardController.reviserNotifier,
          builder: (BuildContext context, Widget? child) {
            return Column(
              children: [
                ReviserLate(
                    quantityCompleted: dashboardController.reviserNotifier.quantityCompleted,
                    quantityDelayed: dashboardController.reviserNotifier.quantityDelayed),
                HourReviser(
                    month: dashboardController.reviserNotifier.quantityHourMonth,
                    week: dashboardController.reviserNotifier.quantityHourWeek),
                NextRevision(
                    future: dashboardController.getNextRevisionLate(),
                    text: 'Próxima revisão atrasada',
                    finishUpdaterReviser: () => reloadPage()),
                NextRevision(
                  future: dashboardController.getNextRevision(),
                  text: 'Próxima revisão',
                  finishUpdaterReviser: () => reloadPage(),
                ),
                const ChartsRevision(),
              ],
            );
          },
        ),
      ),
    );
  }
}
