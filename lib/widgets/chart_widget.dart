import 'package:flutter/material.dart';
import 'package:planeje/dashboard/entities/revision_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key, required this.data, required this.title});

  final List<RevisionData> data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(8),
      child: Center(
        child: SfCartesianChart(
          title: ChartTitle(text: title, textStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 13)),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          primaryXAxis: CategoryAxis(),
          series: <CartesianSeries>[
            LineSeries<RevisionData, String>(
              dataSource: data,
              xValueMapper: (RevisionData data, _) => data.revision,
              yValueMapper: (RevisionData data, _) => data.quantiy,
              markerSettings: MarkerSettings(isVisible: true, width: 4, height: 4),
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
