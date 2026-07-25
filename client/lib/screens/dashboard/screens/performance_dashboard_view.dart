import 'package:flutter/material.dart';

import '../../../providers/dashboard_provider.dart';
import '../../../widgets/latency_chart.dart';
import '../../../widgets/status_code_chart.dart';
import '../widgets/performance_section.dart';
import '../widgets/performance_tabs_content.dart';

class PerformanceDashboardView extends StatelessWidget {
  final DashboardProvider provider;

  const PerformanceDashboardView({super.key, required this.provider});

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
    final sla = _asMap(dashboard['sla_analysis']);
    final capacity = _asMap(dashboard['capacity_analysis']);

    final performance = _asMap(metrics['performance']);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance & Reliability',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Inspect latency, error trends, SRE health, and SLA posture.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          PerformanceTabsContent(
            overviewContent: PerformanceSection(
              incident: incident,
              metrics: metrics,
              sla: sla,
              capacity: capacity,
              risk: risk,
              sreScore: (sre['sre_score'] as num? ?? 0).toDouble(),
            ),
            chartContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Latency Trend',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                LatencyChart(
                  latency: (performance['p95_latency_ms'] as num? ?? 0)
                      .toDouble(),
                ),
                const SizedBox(height: 20),
                Text(
                  'Status Codes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                StatusCodeChart(statusCodes: metrics['status_codes']),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
