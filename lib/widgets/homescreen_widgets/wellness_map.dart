import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class ProgressDashboardCard extends StatelessWidget {
  const ProgressDashboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        border: Border.all(color: MyColors.color1),
        color: Colors.transparent, // White container background
        borderRadius: BorderRadius.circular(15),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity, // Makes the container expand to the full width
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: MyColors.color1, // Green background color
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)), // Optional: Rounded corners
            ),
            child: const Text(
              "Wellness Map",
              textAlign: TextAlign.center, // Centers the text
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color from your custom color class
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
                color: MyColors.color2.withOpacity(0.3),
                border: Border.all(color: MyColors.color1.withOpacity(0.5)),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8))),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMoodDay("Mon", "😊"),
                _buildMoodDay("Tue", "😢"),
                _buildMoodDay("Wed", "😠"),
                _buildMoodDay("Thu", "🤩"),
                _buildMoodDay("Fri", "😄"),
                _buildMoodDay("Sat", "😐"),
                _buildMoodDay("Sun", "😨"),
              ],
            ),
          ),
          const SizedBox(height: 10),




          // Row for user progress, mood trends, and achievements
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // User Progress
              _buildCircularIconWithLabel(
                icon: Icons.speed,
                label: 'Progress',
                value: '95%',
                color: MyColors.color1,
              ),

              // Mood Trends
              _buildCircularIconWithLabel(
                icon: Icons.mood,
                label: 'Mood Trends',
                value: '😊',
                color: MyColors.color1,
              ),

              // Current Achievement
              _buildCircularIconWithLabel(
                icon: Icons.emoji_events,
                label: 'Achievement',
                value: 'Top',
                color: MyColors.color1,
              ),
            ],
          ),
          SizedBox(height: 5,),






        ],
      ),
    );
  }

  // Helper Method for Icon with Circular Container and Label
  Widget _buildCircularIconWithLabel({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color, // Circular background color
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white, // Icon color
            size: 26,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: MyColors.color2,
          ),
        ),

        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
// Helper Method for Daily Moods
Widget _buildMoodDay(String day, String emoji) {
  return Container(
    child: Column(
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: MyColors.color1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          emoji,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ],
    ),
  );
}
