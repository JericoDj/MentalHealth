import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFfcbc1d),
                Color(0xFFfd9c33),
                Color(0xFF59b34d),
                Color(0xFF359d4e),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                _buildMoodSection(context),
              ],
            ),
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
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [

            Color(0xFF59b34d),
            Color(0xFF359d4e),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(8),
        ),
      ),
      child: Text(
        "Wellness Map",
        textAlign: TextAlign.center,
        style: GoogleFonts.archivo(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
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
          Text(day, style: GoogleFonts.archivo(color: Colors.green.shade600, fontWeight: FontWeight.bold,fontSize: 14)),
          const SizedBox(height: 5),
          Text(emoji, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }

  Widget _buildMoodSection(BuildContext context) {
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
          buttonColor: MyColors.color1.withOpacity(0.1),
          iconColor: MyColors.color1,
          borderColor: MyColors.color1,
          displayMode: 'progress',
        ),
        _buildCircularIconWithLabel(
          context,
          icon: Icons.emoji_events,
          label: 'Achievements',
          value: 'My',
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
          iconColor: MyColors.color1,
          displayMode: 'mood_trends',
        ),
        _buildCircularIconWithLabel(
          context,
          icon: Icons.local_fire_department,
          label: 'Stress Level',
          value: 'Moderate',
          buttonColor: MyColors.color2.withOpacity(0.1),
          borderColor: MyColors.color2,
          iconColor: MyColors.color2,
          displayMode: 'stress_level',
        ),
      ],
    );
  }
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
      showDialog(
        context: context,
        builder: (context) => const MoodTrendsPopup(title: 'Your Average Mood', moodSummary: ' Your mood looks good', recommendation: 'Keep going on',),
      );
    // // Navigate to Mood Trends Section and Highlight Da
    //   Navigator.of(context).pop(); // Close existing popup
    //   _scrollToMoodSection(context, selectedDay);
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

