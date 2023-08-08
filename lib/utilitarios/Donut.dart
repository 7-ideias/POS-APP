import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Donut extends StatelessWidget{

  Donut(BuildContext context);

  @override
  Widget build(BuildContext context) {

    final List<ChartData> chartData = [
      ChartData('David', 25, const Color.fromRGBO(9,0,136,1)),
      ChartData('Steve', 38, const Color.fromRGBO(147,0,119,1)),
      ChartData('Jack', 34, const Color.fromRGBO(228,0,124,1)),
      ChartData('Others', 52, const Color.fromRGBO(255,189,57,1))
    ];

    return  Container(
                child: SfCircularChart(
                    series: <CircularSeries>[
                      // Renders doughnut chart
                      DoughnutSeries<ChartData, String>(
                          dataSource: chartData,
                          pointColorMapper:(ChartData data,  _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y
                      ),
                    ]
                ),
            );
  }

}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}