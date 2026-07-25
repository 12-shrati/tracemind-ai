import 'package:flutter/material.dart';
import 'package:tracemind/widgets/ai_card.dart';

class AiInsightsSection extends StatelessWidget {
  final Map<String, dynamic> aiAnalysis;

  const AiInsightsSection({super.key, required this.aiAnalysis});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AiCard(ai: aiAnalysis),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              aiAnalysis['summary']?.toString() ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
