import 'package:flutter/material.dart';

import '../../../providers/dashboard_provider.dart';
import '../widgets/ai_insights_section.dart';

class AiDashboardView extends StatelessWidget {
  final DashboardProvider provider;

  const AiDashboardView({super.key, required this.provider});

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return <String, dynamic>{};
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = provider.dashboard ?? <String, dynamic>{};
    final aiAnalysis = _asMap(dashboard['ai_analysis']);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Insights',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Review AI-generated incident summaries, root cause analysis, and recommended actions.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          AiInsightsSection(aiAnalysis: aiAnalysis),
        ],
      ),
    );
  }
}
