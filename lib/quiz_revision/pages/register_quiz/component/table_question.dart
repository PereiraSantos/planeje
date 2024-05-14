import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/entities/question.dart';

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

  List<Question> listQuestion = [];
  final Function(int, bool) onClick;
  final Function(int) onDelete;

  List<TableRow> table() {
    List<TableRow> list = [
      getRow(
        label: 'Id*',
        description: 'Descrição',
        answer: 'Resposta',
        icon: const SizedBox(),
        color: const Color.fromARGB(66, 158, 158, 158),
      )
    ];

    for (var i = 0; i < listQuestion.length; i++) {
      list.add(
        getRow(
          label: '${listQuestion[i].label}',
          description: '${listQuestion[i].description}',
          child: CheckBoxCustom(
              isChecked: listQuestion[i].answer ?? false, onClick: (value) => onClick(i, value ?? false)),
          icon: GestureDetector(
            onTap: () => onDelete(i),
            child: const Icon(
              Icons.delete_forever,
              color: Color.fromARGB(162, 244, 67, 54),
              size: 23,
            ),
          ),
          color: Colors.white,
        ),
      );
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
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(10),
            2: FixedColumnWidth(64),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: table(),
        ),
      ),
    );
  }
}
