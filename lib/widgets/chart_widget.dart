import 'package:graphic/graphic.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key, required this.data, required this.title, this.color});

  final List<Map<dynamic, dynamic>> data;
  final String title;
  final ColorEncode? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700)),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.maxFinite,
            height: 200,
            child: Chart(
              data: data,
              variables: {
                'revision': Variable(
                  accessor: (Map map) => map['revision'] as String,
                ),
                'quantiy': Variable(
                  accessor: (Map map) => map['quantiy'] as num,
                ),
              },
              marks: [IntervalMark(size: SizeEncode(value: 08), elevation: SizeEncode(value: 02), color: color)],
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
