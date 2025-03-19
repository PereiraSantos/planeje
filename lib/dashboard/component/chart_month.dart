import 'package:graphic/graphic.dart';
import 'package:flutter/material.dart';

class ChartMonth extends StatelessWidget {
  const ChartMonth({super.key, required this.data});

  final List<Map<dynamic, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Column(
        children: [
          Text('Mês', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700)),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.maxFinite,
            height: 150,
            child: Chart(
              data: [
                {'revision': '2-8', 'quantiy': 3},
                {'revision': '9-15', 'quantiy': 4},
                {'revision': '16-22', 'quantiy': 1},
                {'revision': '23-29', 'quantiy': 5}
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
