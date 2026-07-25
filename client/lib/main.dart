import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/dashboard_provider.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'core/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DashboardProvider())],

      child: const TraceMindApp(),
    ),
  );
}

class TraceMindApp extends StatelessWidget {
  const TraceMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: AppTheme.darkTheme,

      home: const DashboardScreen(),
    );
  }
}
