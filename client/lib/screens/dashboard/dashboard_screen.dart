import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import 'screens/ai_dashboard_view.dart';
import 'screens/dashboard_chat_screen.dart';
import 'screens/overview_dashboard_view.dart';
import 'screens/performance_dashboard_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (!mounted) return;
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final provider = context.read<DashboardProvider>();
      provider.loadDashboard();
      provider.startAutoRefresh();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    context.read<DashboardProvider>().stopAutoRefresh();
    super.dispose();
  }

  Widget _buildDashboard(DashboardProvider provider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(),
              labelColor: Colors.white,
              unselectedLabelColor: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant,
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              dividerColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              tabs: [
                _buildStyledTab('Overview', 0),
                _buildStyledTab('AI Insights', 1),
                _buildStyledTab('Performance', 2),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              OverviewDashboardView(provider: provider),
              AiDashboardView(provider: provider),
              PerformanceDashboardView(provider: provider),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStyledTab(String label, int index) {
    final isSelected = _tabController.index == index;
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF7C4DFF) : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.visible,
          style: TextStyle(
            color: isSelected ? Colors.white : colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("TraceMind AI", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "AI Incident Copilot",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),

      body: provider.dashboard == null && provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.dashboard == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_off, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Unable to connect",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text("Please check if the backend server is running."),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: provider.loadDashboard,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            )
          : provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await provider.loadDashboard();
              },
              child: SafeArea(child: _buildDashboard(provider)),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DashboardChatScreen(provider: provider),
            ),
          );
        },
        icon: const Icon(Icons.chat_bubble_outline),
        label: const Text('AI Chat'),
      ),
    );
  }
}
