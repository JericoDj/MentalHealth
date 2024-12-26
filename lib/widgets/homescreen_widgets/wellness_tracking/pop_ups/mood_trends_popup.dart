import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../screens/homescreen/wellness_tracking/progress_map_screen.dart';

class MoodTrendsPopup extends StatelessWidget {
  final String title;
  final String moodSummary;
  final String recommendation;

  const MoodTrendsPopup({
    Key? key,
    required this.title,
    required this.moodSummary,
    required this.recommendation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Row(
        children: [
          const Icon(Icons.mood, color: Colors.orange, size: 30),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            moodSummary,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb, color: Colors.orange),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    recommendation,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Close"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            Get.to(() => const ProgressMapScreen(scrollToIndex: 2));  // Scroll to Mood Trends (Index 2)
          },
          child: const Text("View Details"),
        ),
      ],
    );
  }
}
