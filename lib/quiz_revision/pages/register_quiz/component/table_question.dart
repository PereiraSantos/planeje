import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/utils/register_question/question_list.dart';

import '../../../../widgets/checkbox_custom.dart';
import 'component_table.dart';

// ignore: must_be_immutable
class TableQuestion extends StatelessWidget with ComponentTable {
  TableQuestion({
    super.key,
    required this.listQuestion,
    required this.onClick,
    required this.onDelete,
  });

  List<QuestionList> listQuestion = [];
  final Function(int, bool) onClick;
  final Function(int) onDelete;

  List<TableRow> table() {
    List<TableRow> list = [
      getRow(
        description: 'Descrição',
        answer: 'Resposta',
        icon: const SizedBox(),
        color: const Color.fromARGB(66, 158, 158, 158),
      )
    ];

    for (var i = 0; i < listQuestion.length; i++) {
      if (!listQuestion[i].delete) {
        list.add(
          getRow(
            description: '${listQuestion[i].question?.description}',
            child: CheckBoxCustom(
                isChecked: listQuestion[i].question?.answer ?? false,
                onClick: (value) => onClick(i, value ?? false)),
            icon: GestureDetector(
              onTap: () => onDelete(i),
              child: const Icon(
                Icons.delete_forever,
                color: Color.fromARGB(162, 244, 67, 54),
                size: 20,
              ),
            ),
            color: Colors.white,
          ),
        );
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: listQuestion.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Table(
          border: TableBorder.all(borderRadius: BorderRadius.circular(3), color: Colors.black26),
          columnWidths: const <int, TableColumnWidth>{
            0: FractionColumnWidth(.7),
            1: FractionColumnWidth(.2),
            2: FractionColumnWidth(.1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: table(),
        ),
      ),
    );
  }
}
