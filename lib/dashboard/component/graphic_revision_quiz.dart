import 'package:flutter/material.dart';
import 'package:planeje/dashboard/controller/build_data_graphic.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';
import 'package:planeje/widgets/chart_widget.dart';

class GraphicRevisionQuiz extends StatelessWidget {
  const GraphicRevisionQuiz({super.key, required this.value});

  final List<RevisionQuiz> value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChartWidget(
          data: BuildDataGraphic().buildRevisionQuizRightAnswerYear(value),
          title: 'Quiz respondidos.',
          otherData: BuildDataGraphic().buildRevisionQuizWrongAnswerYear(value),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 12,
              color: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 25),
              child: Text('Respostas corretas'),
            ),
            Container(
              width: 20,
              height: 12,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text('Respostas erradas'),
            ),
          ],
        )
      ],
    );
  }
}
