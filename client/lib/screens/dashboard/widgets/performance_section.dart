import 'package:flutter/material.dart';
import 'package:tracemind/widgets/capacity_card.dart';
import 'package:tracemind/widgets/incident_card.dart';
import 'package:tracemind/widgets/metric_card.dart';
import 'package:tracemind/widgets/risk_card.dart';
import 'package:tracemind/widgets/section_title.dart';
import 'package:tracemind/widgets/sla_card.dart';
import 'package:tracemind/widgets/sre_gauge.dart';

class PerformanceSection extends StatelessWidget {
  final Map<String, dynamic> incident;
  final Map<String, dynamic> metrics;
  final Map<String, dynamic> sla;
  final Map<String, dynamic> capacity;
  final Map<String, dynamic> risk;
  final double sreScore;

  const PerformanceSection({
    super.key,
    required this.incident,
    required this.metrics,
    required this.sla,
    required this.capacity,
    required this.risk,
    required this.sreScore,
  });

  @override
  Widget build(BuildContext context) {
    final performance = metrics['performance'] as Map<String, dynamic>;
    final overview = metrics['overview'] as Map<String, dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Performance', icon: Icons.speed),
        IncidentCard(incident: incident),
        const SizedBox(height: 12),
        MetricCard(
          title: 'Average Latency',
          value: '${performance['average_latency_ms']} ms',
          icon: Icons.speed,
        ),
        MetricCard(
          title: 'P95 Latency',
          value: '${performance['p95_latency_ms']} ms',
          icon: Icons.timer,
        ),
        MetricCard(
          title: 'P99 Latency',
          value: '${performance['p99_latency_ms']} ms',
          icon: Icons.timelapse,
        ),
        MetricCard(
          title: 'Max Latency',
          value: '${performance['max_latency_ms']} ms',
          icon: Icons.show_chart,
        ),
        MetricCard(
          title: 'Error Rate',
          value: '${overview['error_rate']} %',
          icon: Icons.error,
        ),
        const SizedBox(height: 24),
        SreGauge(score: sreScore.toInt()),
        const SizedBox(height: 30),
        Center(
          child: Text(
            'Powered by OpenTelemetry • SigNoz • Gemini AI',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        const SizedBox(height: 20),
        SlaCard(sla: sla),
        const SizedBox(height: 20),
        CapacityCard(capacity: capacity),
        const SizedBox(height: 20),
        RiskCard(risk: risk),
      ],
    );
  }
}
