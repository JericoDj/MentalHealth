import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/moodTrackingController.dart';

class MoodDayWidget extends StatelessWidget {
  final String day;
  final String emoji;

  const MoodDayWidget({Key? key, required this.day, required this.emoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<MoodTrackingController>().showDailyMoodPopup(day, emoji, context);
      },
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(emoji, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
