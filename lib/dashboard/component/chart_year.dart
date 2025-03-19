import 'package:graphic/graphic.dart';
import 'package:flutter/material.dart';

class ChartYear extends StatelessWidget {
  const ChartYear({super.key, required this.data});

  final List<Map<dynamic, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Column(
        children: [
          Text('Ano', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700)),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.maxFinite,
            height: 200,
            child: Chart(
              data: [
                {'revision': 'Jan.', 'quantiy': 20},
                {'revision': 'Fev.', 'quantiy': 11},
                {'revision': 'Mar.', 'quantiy': 15},
                {'revision': 'Abr.', 'quantiy': 12},
                {'revision': 'Mai.', 'quantiy': 18},
                {'revision': 'Jun.', 'quantiy': 30},
                {'revision': 'Jul.', 'quantiy': 25},
                {'revision': 'Ago.', 'quantiy': 8},
                {'revision': 'Set.', 'quantiy': 29},
                {'revision': 'Out.', 'quantiy': 9},
                {'revision': 'Nov.', 'quantiy': 10},
                {'revision': 'Dez.', 'quantiy': 11},
              ],
              variables: {
                'revision': Variable(
                  accessor: (Map map) => map['revision'] as String,
                ),
                'quantiy': Variable(
                  accessor: (Map map) => map['quantiy'] as num,
                ),
              },
              marks: [
                IntervalMark(
                  size: SizeEncode(value: 08),
                  elevation: SizeEncode(value: 02),
                  color: ColorEncode(value: const Color.fromARGB(164, 76, 175, 79)),
                )
              ],
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
