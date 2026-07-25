import 'package:flutter/material.dart';

import '../../../widgets/summary_card.dart';

class OverviewSummaryGrid extends StatelessWidget {
  final Map<String, dynamic> incident;
  final Map<String, dynamic> sre;
  final Map<String, dynamic> risk;
  final Map<String, dynamic> overview;

  const OverviewSummaryGrid({
    super.key,
    required this.incident,
    required this.sre,
    required this.risk,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        SummaryCard(
          title: 'Health',
          value: incident['health'].toString(),
          color: Colors.green,
          icon: Icons.health_and_safety,
        ),
        SummaryCard(
          title: 'SRE Score',
          value: sre['sre_score'].toString(),
          color: Colors.orange,
          icon: Icons.analytics,
        ),
        SummaryCard(
          title: 'Risk',
          value: risk['risk_level'].toString(),
          color: Colors.red,
          icon: Icons.warning,
        ),
        SummaryCard(
          title: 'Requests',
          value: overview['total_requests'].toString(),
          color: Colors.blue,
          icon: Icons.public,
        ),
      ],
    );
  }
}
