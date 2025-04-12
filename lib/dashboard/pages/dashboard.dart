import 'package:flutter/material.dart';
import 'package:planeje/dashboard/component/future_builder_component.dart';
import 'package:planeje/dashboard/component/graphic_revision_quiz.dart';
import 'package:planeje/dashboard/controller/build_data_graphic.dart';
import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/revision_quiz.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/widgets/chart_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void reloadPage() => setState(() {});

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
        toolbarHeight: 46,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilderComponent<DateRevision>(
              future: DateRevisionDatabaseDataSource().findAllDateRevisions(),
              children: (value) => ChartWidget(data: BuildDataGraphic().buildRevisionYear(value), title: 'Revisões realizadas.'),
            ),
            FutureBuilderComponent<RevisionQuiz>(
              future: GetRevisionQuiz(RevisionQuizDatabase()).getAllRevisionQuiz(''),
              children: (value) => GraphicRevisionQuiz(value: value),
            ),
          ],
        ),
      ),
    );
  }
}
