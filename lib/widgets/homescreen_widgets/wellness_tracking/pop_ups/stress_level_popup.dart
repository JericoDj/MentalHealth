import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../screens/homescreen/wellness_tracking/progress_map_screen.dart';

class StressLevelPopup extends StatelessWidget {
  const StressLevelPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Stress Level"),
      content: const Text(
        "Current Stress Level: Moderate\n\nRecommendation:\n- Try breathing exercises\n- Take a short walk\n- Listen to relaxing music.",
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
            Get.to(() => const ProgressMapScreen(scrollToIndex: 3));  // Scroll to Stress Section (Index 3)
          },
          child: const Text("Manage Stress"),
        ),
      ],
    );
  }
}
