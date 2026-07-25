import 'package:flutter/material.dart';

class SeverityChip extends StatelessWidget {
  final String severity;

  const SeverityChip({super.key, required this.severity});

  Color get color {
    switch (severity) {
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
    return Chip(
      backgroundColor: color,

      label: Text(
        severity,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
