import 'package:flutter/material.dart';

class MoodTrendsSection extends StatelessWidget {
  final GlobalKey key;

  const MoodTrendsSection({required this.key, Key? widgetKey}) : super(key: widgetKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "Mood Trends Section",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
