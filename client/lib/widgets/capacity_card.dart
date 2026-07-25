import 'package:flutter/material.dart';

class CapacityCard extends StatelessWidget {
  final Map<String, dynamic> capacity;

  const CapacityCard({super.key, required this.capacity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "⚡ Capacity",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            ListTile(
              leading: const Icon(Icons.memory),
              title: const Text("CPU"),
              trailing: Text("${capacity["cpu_usage"]}%"),
            ),

            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text("Memory"),
              trailing: Text("${capacity["memory_usage"]}%"),
            ),

            ListTile(
              leading: const Icon(Icons.network_check),
              title: const Text("Recommendation"),
              subtitle: Text(capacity["recommendation"] ?? "-"),
            ),
          ],
        ),
      ),
    );
  }
}
