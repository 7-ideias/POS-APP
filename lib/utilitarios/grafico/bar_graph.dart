import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pos_app/utilitarios/grafico/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List diasSemana;

  Widget tituloInferior(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()){
      case 0:
        text = const Text('D',style: style,);
        break;
      case 1:
        text = const Text('S',style: style,);
        break;
      case 2:
        text = const Text('T',style: style,);
        break;
      case 3:
        text = const Text('Q',style: style,);
        break;
      case 4:
        text = const Text('Q',style: style,);
        break;
      case 5:
        text = const Text('S',style: style,);
        break;
      case 6:
        text = const Text('Q',style: style,);
        break;
      default:
        text = const Text('',style: style,);
    }
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }


  const MyBarGraph({super.key, required this.diasSemana});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        domQuantia: diasSemana[0],
        segQuantia: diasSemana[1],
        terQuantia: diasSemana[2],
        quarQuantia: diasSemana[3],
        quinQuantia: diasSemana[4],
        sexQuantia: diasSemana[5],
        sabQuantia: diasSemana[6]);
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 200,
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(sideTitles: SideTitles(
            showTitles: true, getTitlesWidget: tituloInferior
          ),),
        ),
        barGroups: myBarData.barraData
            .map((data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: Colors.yellow,
                      width: 15,
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
