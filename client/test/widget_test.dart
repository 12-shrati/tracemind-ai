import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tracemind/widgets/summary_card.dart';

void main() {
  testWidgets('SummaryCard does not overflow in a compact layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 160,
              height: 120,
              child: SummaryCard(
                title: 'Health',
                value: 'Degraded',
                color: Colors.red,
                icon: Icons.warning,
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
