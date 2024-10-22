import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(right: 18, top: 18, bottom: 18),
        child: BarChart(
          BarChartData(
            backgroundColor: Colors.white,
            titlesData: FlTitlesData(
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false, reservedSize: 40)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  interval: 5,
                  reservedSize: 35,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups: [
              BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5)]),
              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 40)]),
              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 30)]),
              BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 60)]),
              BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 75)]),
              BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 35)]),
              BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 42)]),
              BarChartGroupData(x: 7, barRods: [BarChartRodData(toY: 33)]),
              BarChartGroupData(x: 8, barRods: [BarChartRodData(toY: 60)]),
              BarChartGroupData(x: 9, barRods: [BarChartRodData(toY: 90)]),
              BarChartGroupData(x: 10, barRods: [BarChartRodData(toY: 86)]),
              BarChartGroupData(x: 11, barRods: [BarChartRodData(toY: 95)]),
            ],
          ),
        ),
      ),
    );
  }
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Tabuľka výsledkov podľa odpovedí',
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: const AspectRatio(
        aspectRatio: 16 / 19,
        child: _BarChart(),
      ),
    );
  }
}
