import 'dart:async';
import 'package:flutter/material.dart';
import '../core/api_service.dart';

class DashboardProvider extends ChangeNotifier {
  final ApiService api = ApiService();

  bool isLoading = true;

  Map<String, dynamic>? dashboard;

  DateTime? lastUpdated;

  Timer? _timer;
  bool _disposed = false;

  Future<void> loadDashboard() async {
    if (_disposed) return;

    try {
      isLoading = true;
      _notifySafely();

      dashboard = await api.getDashboard();
      lastUpdated = DateTime.now();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (_disposed) return;

      isLoading = false;
      _notifySafely();
    }
  }

  Future<String> askDashboardChat(String question) async {
    try {
      final response = await api.askDashboardChat(question, dashboard!);

      return response;
    } catch (e, stackTrace) {
      debugPrint("Chat Error: $e");
      debugPrintStack(stackTrace: stackTrace);
      return "Error: $e";
    }
  }

  void _notifySafely() {
    if (_disposed || !hasListeners) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_disposed && hasListeners) {
        notifyListeners();
      }
    });
  }

  void startAutoRefresh() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(minutes: 30),
      (_) => unawaited(loadDashboard()),
    );
  }

  void stopAutoRefresh() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _disposed = true;
    stopAutoRefresh();
    super.dispose();
  }
}
