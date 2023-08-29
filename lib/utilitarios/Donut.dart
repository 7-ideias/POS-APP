import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/app_controller.dart';

class Donut extends StatelessWidget {
  Donut(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25, const Color.fromRGBO(9, 0, 136, 1)),
      ChartData('Steve', 38, const Color.fromRGBO(147, 0, 119, 1)),
      ChartData('Jack', 34, const Color.fromRGBO(228, 0, 124, 1)),
      ChartData('Others', 52, const Color.fromRGBO(255, 189, 57, 1))
    ];
    return Container(
      child: SfCircularChart(
        series: <CircularSeries>[
          // Renders doughnut chart
          DoughnutSeries<ChartData, String>(
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            explode: true,
            explodeAll: true,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(
                color: Colors.black,
              ),
              connectorLineSettings: ConnectorLineSettings(
                color: Colors.white,
              ),
              margin: EdgeInsets.all(10),
            ),
            cornerStyle: CornerStyle.bothFlat,
            selectionBehavior: SelectionBehavior(
              enable: true,
              selectedBorderColor: Colors.white,
              unselectedBorderColor: Colors.transparent,
              selectedBorderWidth: 0.2,
              toggleSelection: true,
            ),
            startAngle: 270,
            endAngle: 270,
            innerRadius: '70%',
          ),
        ],
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
