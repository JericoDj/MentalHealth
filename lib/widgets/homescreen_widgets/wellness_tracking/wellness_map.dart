import 'package:flutter/material.dart';
import 'package:get/get.dart'; // For navigation
import '../../../../screens/homescreen/wellness_tracking/wellness_tracking_page.dart';
import '../../../../utils/constants/colors.dart';

class ProgressDashboardCard extends StatelessWidget {
  const ProgressDashboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.color1),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: MyColors.color1,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)),
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
          ),

          // Daily Mood Section
          Container(
            decoration: BoxDecoration(
              color: MyColors.color2.withOpacity(0.3),
              border: Border.all(color: MyColors.color1.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMoodDay("Mon", "😊", context),
                _buildMoodDay("Tue", "😢", context),
                _buildMoodDay("Wed", "😠", context),
                _buildMoodDay("Thu", "🤩", context),
                _buildMoodDay("Fri", "😄", context),
                _buildMoodDay("Sat", "😐", context),
                _buildMoodDay("Sun", "😨", context),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Circular Buttons Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircularIconWithLabel(
                context,
                icon: Icons.speed,
                label: 'Progress',
                value: '95%',
                color: MyColors.color1,
                onTap: () => Get.to(() => const WellnessTrackingPage(
                  displayMode: 'progress',
                )),
              ),
              _buildCircularIconWithLabel(
                context,
                icon: Icons.mood,
                label: 'Mood Trends',
                value: '😊',
                color: MyColors.color1,
                onTap: () => Get.to(() => const WellnessTrackingPage(
                  displayMode: 'mood_trends',
                )),
              ),
              _buildCircularIconWithLabel(
                context,
                icon: Icons.emoji_events,
                label: 'Achievement',
                value: 'Top',
                color: MyColors.color1,
                onTap: () => Get.to(() => const WellnessTrackingPage(
                  displayMode: 'achievement',
                )),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildCircularIconWithLabel(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required Color color,
        required Function() onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
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
      onTap: () => Get.to(() => WellnessTrackingPage(
        displayMode: 'daily_mood',
        selectedDay: day,
      )),
      child: Column(
        children: [
          Text(day, style: TextStyle(color: MyColors.color1)),
          const SizedBox(height: 5),
          Text(emoji, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
