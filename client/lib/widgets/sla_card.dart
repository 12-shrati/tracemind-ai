import 'package:flutter/material.dart';

class SlaCard extends StatelessWidget {
  final Map<String, dynamic> sla;

  const SlaCard({super.key, required this.sla});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📋 SLA Analysis",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text("Availability"),
              trailing: Text("${sla["availability"]}%"),
            ),

            ListTile(
              leading: const Icon(Icons.speed),
              title: const Text("Latency Target"),
              trailing: Text("${sla["latency_target_ms"]} ms"),
            ),

            ListTile(
              leading: const Icon(Icons.warning_amber),
              title: const Text("SLA Status"),
              trailing: Text(sla["status"] ?? "-"),
            ),
          ],
        ),
      ),
    );
  }
}
