import 'package:flutter/material.dart';

class WellnessTrackingPage extends StatelessWidget {
  final String displayMode; // Determines if we show progress, mood trends, or achievements
  final String selectedDay; // Only for daily mood tracking

  const WellnessTrackingPage({
    Key? key,
    required this.displayMode,
    this.selectedDay = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (displayMode) {
      case 'progress':
        content = _buildUserProgress();
        break;
      case 'mood_trends':
        content = _buildMoodTrends();
        break;
      case 'achievement':
        content = _buildAchievements();
        break;
      case 'daily_mood':
        content = _buildDailyMoodTracking();
        break;
      default:
        content = const Center(child: Text("Invalid Selection"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(displayMode == 'daily_mood'
            ? "Mood for $selectedDay"
            : "Wellness Tracking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }

  // Mock Data for Visualization
  Widget _buildUserProgress() {
    return const Center(
      child: Text(
        "User Progress: 20 Check-ins This Month",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildMoodTrends() {
    return const Center(
      child: Text(
        "Mood Trends: 😄😊😊😐😢",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildAchievements() {
    return const Center(
      child: Text(
        "Achievements: 3 Milestones Reached",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildDailyMoodTracking() {
    return Center(
      child: Text(
        "Mood Tracking for $selectedDay: 😊",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
