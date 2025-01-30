import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../screens/homescreen/wellness_tracking/progress_map_screen.dart';
import '../../../../utils/constants/colors.dart'; // Assuming MyColors is imported from this file

class AchievementsPopup extends StatelessWidget {
  const AchievementsPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Achievements",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red, size: 24),
                    onPressed: () => Navigator.pop(context), // Close dialog
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Content Text
            const Text(
              "Achievements Unlocked:\n🏆 10 Day Streak\n🏅 50 Check-ins\n🥇 Consistent Moods Logged\n\nNext Achievement: 100 Check-ins",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Buttons (Row for "View Achievements" & "Close")
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Get.to(() => const ProgressMapScreen(scrollToIndex: 1)); // Scroll to Achievements Section (Index 1)
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    style: BorderStyle.solid,
                    color: MyColors.color1, // Border color
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  "View Achievements",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyColors.color1, // Text color matches the border
                  ),
                ),
              ),
            ),
            // Close Button with Gradient Border

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
