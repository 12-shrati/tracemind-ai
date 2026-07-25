import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final DateTime? lastUpdated;

  const DashboardHeader({super.key, required this.lastUpdated});

  @override
  Widget build(BuildContext context) {
    if (lastUpdated == null) {
      return const SizedBox.shrink();
    }

    return Text(
      'Last updated: ${lastUpdated!.toLocal().toString().substring(0, 19)}',
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}
