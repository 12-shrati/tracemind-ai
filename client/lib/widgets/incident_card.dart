import 'package:flutter/material.dart';

class IncidentCard extends StatelessWidget {
  final Map<String, dynamic> incident;

  const IncidentCard({super.key, required this.incident});

  Color getSeverityColor(String severity) {
    switch (severity.toUpperCase()) {
      case "CRITICAL":
        return Colors.red;
      case "HIGH":
        return Colors.orange;
      case "MEDIUM":
        return Colors.amber;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final severity = incident["severity"] ?? "UNKNOWN";
    final alerts = incident["alerts"] as List? ?? [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🚨 Incident",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Text(
                  "Health: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(incident["health"] ?? "-"),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Text(
                  "Severity: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Chip(
                  backgroundColor: getSeverityColor(severity),
                  label: Text(
                    severity,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Text(
                  "Confidence: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${incident["confidence"] ?? 0}%"),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              "Alerts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 8),

            if (alerts.isEmpty)
              const Text("No active alerts")
            else
              ...alerts.map(
                (alert) => ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                  ),
                  title: Text(alert.toString()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
