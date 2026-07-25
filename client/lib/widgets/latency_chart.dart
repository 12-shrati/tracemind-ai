import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LatencyChart extends StatelessWidget {
  final double latency;

  const LatencyChart({super.key, required this.latency});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(show: false),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  spots: [
                    FlSpot(0, latency * .6),
                    FlSpot(1, latency * .7),
                    FlSpot(2, latency * .8),
                    FlSpot(3, latency * .9),
                    FlSpot(4, latency),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
