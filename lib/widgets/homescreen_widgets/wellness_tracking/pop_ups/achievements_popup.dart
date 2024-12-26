import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../screens/homescreen/wellness_tracking/progress_map_screen.dart';

class AchievementsPopup extends StatelessWidget {
  const AchievementsPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Achievements"),
      content: const Text(
        "Achievements Unlocked:\n🏆 10 Day Streak\n🏅 50 Check-ins\n🥇 Consistent Moods Logged\n\nNext Achievement: 100 Check-ins",
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Close"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            Get.to(() => const ProgressMapScreen(scrollToIndex: 1));  // Scroll to Achievements Section (Index 1)
          },
          child: const Text("View Achievements"),
        ),
      ],
    );
  }
}
