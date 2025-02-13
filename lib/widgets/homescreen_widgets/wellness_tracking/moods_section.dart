
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/wellness_tracking/wellness_map.dart';

import '../../../controllers/moodTrackingController.dart';

final MoodTrackingController moodController = Get.put(MoodTrackingController()); // Inject Controller

Widget buildMoodSection(BuildContext context) {
  moodController.fetchUserMoodData(); // Ensures data is fetched on UI build

  return Obx(() {
    final moods = moodController.userMoods;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].map((day) {
          return buildMoodDay(day, moods[day] ?? "◽️", context); // Default to neutral
        }).toList(),
      ),
    );
  });
}




Widget buildMoodDay(String day, String emoji, BuildContext context) {
  return GestureDetector(
    onTap: () {
      showTrackingPopup(context, 'daily_mood', selectedDay: day, mood: emoji);
    },
    child: Column(
      children: [
        Text(day, style: GoogleFonts.archivo(color: Colors.green.shade600, fontWeight: FontWeight.bold,fontSize: 14)),
        const SizedBox(height: 5),
        Text(emoji, style: const TextStyle(fontSize: 24)),
      ],
    ),
  );
}
