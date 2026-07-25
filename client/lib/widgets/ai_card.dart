import 'package:flutter/material.dart';

class AiCard extends StatelessWidget {
  final Map<String, dynamic> ai;

  const AiCard({super.key, required this.ai});

  Widget buildList(List<dynamic> items) {
    return Column(
      children: items.map((e) {
        return ListTile(
          leading: const Icon(Icons.check_circle, color: Colors.green),
          title: Text(e.toString()),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🤖 AI Analysis",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text(ai["summary"], style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            const Text(
              "Root Cause",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Text(ai["root_cause"]),

            const SizedBox(height: 20),

            const Text(
              "Business Impact",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Text(ai["business_impact"]),

            const SizedBox(height: 20),

            const Text(
              "Immediate Actions",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            buildList(ai["immediate_actions"]),

            const SizedBox(height: 20),

            const Text(
              "Long Term Fixes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            buildList(ai["long_term_fixes"]),
          ],
        ),
      ),
    );
  }
}
