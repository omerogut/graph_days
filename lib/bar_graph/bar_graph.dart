import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graph_days/bar_graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thiAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thiAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  @override
  Widget build(BuildContext context) {
    //initialize the bar data
    BarData myBarData = BarData(
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thuAmount: thiAmount,
        friAmount: friAmount,
        satAmount: satAmount,
        sunAmount: sunAmount);
    myBarData.initializeBarData();

    return BarChart(BarChartData(
        maxY: maxY,
        minY: 0,
        titlesData: FlTitlesData(show: true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTitles,
          ),
        ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
            x: data.x,
            barRods: [
              BarChartRodData(
                toY: data.y,
                color: Colors.brown.shade200,
                width: 20,
                borderRadius: BorderRadius.circular(4),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: Colors.blueGrey[200],
                )
              ),
            ],
        ))
            .toList(),
    ));
  }
}

Widget getBottomTitles(double value, TitleMeta meta){
  const style = TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch(value.toInt()){
    case 0:
      text = const Text('MO', style:style);
      break;
    case 1:
      text = const Text('TU', style:style);
      break;
    case 2:
      text = const Text('WE', style:style);
      break;
    case 3:
      text = const Text('TH', style:style);
      break;
    case 4:
      text = const Text('FR', style:style);
      break;
    case 5:
      text = const Text('ST', style:style);
      break;
    case 6:
      text = const Text('SU', style:style);
      break;
    default:
      text = const Text('', style:style);
  break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide,);
}
