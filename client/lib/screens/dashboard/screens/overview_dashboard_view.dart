import 'package:flutter/material.dart';

import '../../../providers/dashboard_provider.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/overview_summary_grid.dart';

class OverviewDashboardView extends StatelessWidget {
  final DashboardProvider provider;

  const OverviewDashboardView({super.key, required this.provider});

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
    final incident = _asMap(dashboard['incident']);
    final sre = _asMap(dashboard['sre_analysis']);
    final risk = _asMap(dashboard['risk_analysis']);
    final metrics = _asMap(dashboard['metrics']);
    final overview = _asMap(metrics['overview']);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardHeader(lastUpdated: provider.lastUpdated),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Live incident overview',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Monitor the current service health, risks, and request volume in one place.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OverviewSummaryGrid(
            incident: incident,
            sre: sre,
            risk: risk,
            overview: overview,
          ),

          const SizedBox(height: 30),
          Center(
            child: Text(
              'Powered by OpenTelemetry • SigNoz • Gemini AI',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
