
// Separate Button for Insight Quest
import 'package:flutter/material.dart';

class InsightQuestButton extends StatelessWidget {
  @override
  Widget build(BuildContext conext) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const Icon(Icons.psychology, size: 40, color: Colors.blue),
        title: const Text(
          'Insight Quest',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Science-based quizzes to boost your insights.',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        onTap: () {
          // Navigate to Insight Quest Page
        },
      ),
    );
  }
}