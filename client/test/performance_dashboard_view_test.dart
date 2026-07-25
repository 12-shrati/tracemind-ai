import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracemind/providers/dashboard_provider.dart';
import 'package:tracemind/screens/dashboard/screens/performance_dashboard_view.dart';

void main() {
  testWidgets('performance tabs remain scrollable when switching views', (
    tester,
  ) async {
    final provider = DashboardProvider()
      ..dashboard = {
        'incident': {},
        'sre_analysis': {'sre_score': 85},
        'risk_analysis': {},
        'metrics': {
          'performance': {
            'average_latency_ms': 120,
            'p95_latency_ms': 240,
            'p99_latency_ms': 390,
            'max_latency_ms': 500,
          },
          'overview': {'error_rate': 0.4},
          'status_codes': {'200': 10, '500': 2},
        },
        'sla_analysis': {},
        'capacity_analysis': {},
      };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 320,
            child: PerformanceDashboardView(provider: provider),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Trends'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('performance view handles missing nested dashboard values', (
    tester,
  ) async {
    final provider = DashboardProvider()
      ..dashboard = {
        'incident': null,
        'sre_analysis': null,
        'risk_analysis': null,
        'metrics': {
          'performance': null,
          'overview': null,
          'status_codes': null,
        },
        'sla_analysis': null,
        'capacity_analysis': null,
      };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 320,
            child: PerformanceDashboardView(provider: provider),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
