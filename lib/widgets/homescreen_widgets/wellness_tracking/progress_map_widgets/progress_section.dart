import 'package:flutter/material.dart';

class ProgressSection extends StatelessWidget {
  final GlobalKey key;

  const ProgressSection({required this.key, Key? widgetKey}) : super(key: widgetKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "User Progress: 25 Check-ins\nStreak: 10 Days",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
