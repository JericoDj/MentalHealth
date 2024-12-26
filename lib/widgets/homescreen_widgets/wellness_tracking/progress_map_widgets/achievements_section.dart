import 'package:flutter/material.dart';

class AchievementsSection extends StatelessWidget {
  final GlobalKey key;

  const AchievementsSection({required this.key, Key? widgetKey}) : super(key: widgetKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "Achievements Unlocked:\n🏆 10 Day Streak\n🏅 50 Check-ins",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
