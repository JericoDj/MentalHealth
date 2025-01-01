import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/wellness_tracking/pop_ups/achievements_popup.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/wellness_tracking/pop_ups/daily_mood_popup.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/wellness_tracking/pop_ups/mood_trends_popup.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/wellness_tracking/pop_ups/progress_popup.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/wellness_tracking/pop_ups/stress_level_popup.dart';

import '../../../../utils/constants/colors.dart';
import '../../../screens/homescreen/wellness_tracking/progress_map_screen.dart';

class ProgressDashboardCard extends StatelessWidget {
  ProgressDashboardCard({Key? key}) : super(key: key);

  // Moods for each day (Dynamic)
  final Map<String, String> dailyMoods = {
    "Mon": "😊",
    "Tue": "😢",
    "Wed": "😠",
    "Thu": "🤩",
    "Fri": "😄",
    "Sat": "😐",
    "Sun": "😨",
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.color1),
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              _buildMoodSection(context),

            ],
          ),
        ),
        const SizedBox(height: 10),
        _buildProgressButtons(context),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: MyColors.color1,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: const Text(
        "Wellness Map",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMoodSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(


        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: dailyMoods.keys.map((day) {
          return _buildMoodDay(day, dailyMoods[day]!, context);
        }).toList(),
      ),
    );
  }

  Widget _buildProgressButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCircularIconWithLabel(
          context,
          icon: Icons.speed,
          label: 'Progress',
          value: '95%',
          buttonColor: MyColors.color2.withOpacity(0.1),
          iconColor: MyColors.color2,
          borderColor: MyColors.color2,
          displayMode: 'progress',
        ),
        _buildCircularIconWithLabel(
          context,
          icon: Icons.emoji_events,
          label: 'Achievement',
          value: 'Top',
          buttonColor: MyColors.color2.withOpacity(0.1),
          borderColor: MyColors.color2,
          iconColor: MyColors.color2,
          displayMode: 'achievement',
        ),
        _buildCircularIconWithLabel(
          context,
          icon: Icons.mood,
          label: 'Mood Trends',
          value: '😊',
          buttonColor: Colors.green.shade600.withOpacity(0.1),
          borderColor: MyColors.color1,
          iconColor: Colors.green.shade600,
          displayMode: 'mood_trends',
        ),
        _buildCircularIconWithLabel(
          context,
          icon: Icons.local_fire_department,
          label: 'Stress Level',
          value: 'Moderate',
          buttonColor: Colors.redAccent.withOpacity(0.1),
          borderColor: Colors.redAccent.shade100,
          iconColor: Colors.redAccent,
          displayMode: 'stress_level',
        ),

      ],
    );
  }

  Widget _buildCircularIconWithLabel(BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color borderColor,
    required Color iconColor,
    required Color buttonColor,
    required String displayMode,
  }) {
    return GestureDetector(
      onTap: () {
        _showPopup(context, displayMode);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1.5),  // Border color
              color: buttonColor,  // Background color of the circle
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,  // Icon color
              size: 26,
            ),
          ),
          const SizedBox(height: 5),
          Text(value),
          Text(label),
        ],
      ),
    );
  }



  Widget _buildMoodDay(String day, String emoji, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPopup(context, 'daily_mood', selectedDay: day, mood: emoji);
      },
      child: Column(
        children: [
          Text(day, style: TextStyle(color: Colors.green.shade600)),
          const SizedBox(height: 5),
          Text(emoji, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }

  // Trigger the Appropriate Pop-up
  void _showPopup(BuildContext context, String mode,
      {String selectedDay = "", String mood = "😊"}) {
    switch (mode) {
      case 'progress':
        showDialog(
          context: context,
          builder: (context) => const ProgressPopup(),
        );
        break;
      case 'mood_trends':
      // Navigate to Mood Trends Section and Highlight Day
        Navigator.of(context).pop(); // Close existing popup
        _scrollToMoodSection(context, selectedDay);
        break;
      case 'stress_level':
        showDialog(
          context: context,
          builder: (context) => const StressLevelPopup(),
        );
        break;
      case 'achievement':
        showDialog(
          context: context,
          builder: (context) => const AchievementsPopup(),
        );
        break;
      case 'daily_mood':
        showDialog(
          context: context,
          builder: (context) =>
              DailyMoodPopup(
                mood: mood,
                selectedDay: selectedDay,
              ),
        );
        break;
      default:
        break;
    }
  }

  void _scrollToMoodSection(BuildContext context, String selectedDay) {
    // Navigate to ProgressMapScreen and Scroll to Mood Section
    Get.to(() => ProgressMapScreen(scrollToIndex: 2, selectedDay: selectedDay));
  }

}