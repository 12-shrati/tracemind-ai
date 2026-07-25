import 'package:flutter/material.dart';

class RiskCard extends StatelessWidget {
  final Map<String, dynamic> risk;

  const RiskCard({super.key, required this.risk});

  Color get color {
    switch ((risk["risk_level"] ?? "").toString().toUpperCase()) {
      case "HIGH":
        return Colors.red;
      case "MEDIUM":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🛡 Risk Analysis",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Chip(
              backgroundColor: color,
              label: Text(
                risk["risk_level"] ?? "UNKNOWN",
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 12),

            Text(risk["summary"] ?? ""),
          ],
        ),
      ),
    );
  }
}
