import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../screens/homescreen/wellness_tracking/progress_map_screen.dart';

class ProgressPopup extends StatelessWidget {
  const ProgressPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("User Progress"),
      content: const Text(
        "You have checked in 25 times this month!\nStreak: 10 days in a row.\nKeep up the great work!",
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
            Get.to(() => const ProgressMapScreen(scrollToIndex: 0));  // Scroll to User Progress (Index 0)
          },
          child: const Text("View Progress"),
        ),
      ],
    );
  }
}
