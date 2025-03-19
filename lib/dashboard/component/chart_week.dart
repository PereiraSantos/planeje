import 'package:graphic/graphic.dart';
import 'package:flutter/material.dart';

class ChartWeek extends StatelessWidget {
  const ChartWeek({super.key, required this.data});

  final List<Map<dynamic, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Column(
        children: [
          Text('Semana', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700)),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.maxFinite,
            height: 150,
            child: Chart(
              data: [
                {'revision': 'Seg', 'quantiy': 2},
                {'revision': 'Ter', 'quantiy': 1},
                {'revision': 'Qua', 'quantiy': 0},
                {'revision': 'Qui', 'quantiy': 0},
                {'revision': 'Sex', 'quantiy': 1},
                {'revision': 'Sab', 'quantiy': 3},
                {'revision': 'Dom', 'quantiy': 5},
              ],
              variables: {
                'revision': Variable(
                  accessor: (Map map) => map['revision'] as String,
                ),
                'quantiy': Variable(
                  accessor: (Map map) => map['quantiy'] as num,
                ),
              },
              marks: [IntervalMark(size: SizeEncode(value: 08))],
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
