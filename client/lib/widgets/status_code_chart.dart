import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatusCodeChart extends StatelessWidget {
  final Map<String, dynamic> statusCodes;

  const StatusCodeChart({super.key, required this.statusCodes});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.blue,
      Colors.purple,
    ];

    int index = 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "HTTP Status Codes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sections: statusCodes.entries.map((entry) {
                    final section = PieChartSectionData(
                      color: colors[index % colors.length],
                      value: (entry.value as num).toDouble(),
                      title: entry.key,
                      radius: 70,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );

                    index++;

                    return section;
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              children: statusCodes.entries.map((entry) {
                final color =
                    colors[statusCodes.keys.toList().indexOf(entry.key)];

                return Chip(
                  backgroundColor: color,
                  label: Text(
                    "${entry.key} : ${entry.value}",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
