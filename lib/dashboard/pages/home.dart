import 'package:flutter/material.dart';
import 'package:planeje/annotation/pages/list_annotation/page/list_annotation.dart';
import 'package:planeje/dashboard/utils/find_revision.dart';
import 'package:planeje/dashboard/utils/next_revision_time.dart';
import 'package:planeje/dashboard/controller/reviser_notifier.dart';
import 'package:planeje/dashboard/utils/valid_date.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision_page.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/utils/type_message.dart';

import '../../quiz_revision/pages/list_quiz/page/list_quiz.dart';
import '../../revision/entities/revision.dart';
import '../../revision/pages/list_revision/page/list_revision.dart';
import '../../usercase/transitions_builder.dart';
import '../../widgets/app_bar_widget.dart';
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
              callbackHome: () => Navigator.of(context).push(TransitionsBuilder.createRoute(const Home())),
              callbackReviser: () =>
                  Navigator.of(context).push(TransitionsBuilder.createRoute(const ListRevision())),
              callbackAnnotation: () =>
                  Navigator.of(context).push(TransitionsBuilder.createRoute(const ListAnnotation())),
              callBackQuiz: () =>
                  Navigator.of(context).push(TransitionsBuilder.createRoute(const ListQuiz())),
              callbackAdd: () async {
                var result = await Navigator.of(context).push(
                  TransitionsBuilder.createRoute(
                    RegisterRevisionPage(
                      revision: Register(RevisionDatabaseDataSource(), Revision(), Message(),
                          RegisterDateRevision(DateRevisionDatabaseDataSource(), DateRevision())),
                    ),
                  ),
                );

                if (result) reloadPage();
              },
              callbackFilter: () {
                reloadPage();
              },
              colorHome: Colors.black54,
              showAction: false,
              quantity: reviserNotifier.quantityDelayed,
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
