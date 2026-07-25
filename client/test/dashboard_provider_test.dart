import 'package:flutter_test/flutter_test.dart';
import 'package:tracemind/providers/dashboard_provider.dart';

void main() {
  group('DashboardProvider', () {
    test('does not notify after dispose', () async {
      final provider = DashboardProvider();
      var notifications = 0;

      provider.addListener(() {
        notifications++;
      });

      provider.dispose();

      await provider.loadDashboard();

      expect(notifications, 0);
    });
  });
}
