import 'package:flutter/material.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class AchievementsSection extends StatelessWidget {
  AchievementsSection({
    Key? key,
    required List<GlobalKey<State<StatefulWidget>>> sectionKeys,
  }) : _sectionKeys = sectionKeys, super(key: key);

  final List<GlobalKey<State<StatefulWidget>>> _sectionKeys;

  // Sample Achievement Data
  final List<Map<String, dynamic>> _achievements = [
    {
      "title": "10 Day Streak",
      "icon": Icons.local_fire_department,
      "progress": 10,
      "goal": 10,
      "unlocked": true,
    },
    {
      "title": "50 Check-ins",
      "icon": Icons.check_circle_outline,
      "progress": 50,
      "goal": 50,
      "unlocked": true,
    },
    {
      "title": "Consistent Moods Logged",
      "icon": Icons.emoji_emotions,
      "progress": 30,
      "goal": 40,
      "unlocked": false,
    },
    {
      "title": "100 Check-ins",
      "icon": Icons.star,
      "progress": 50,
      "goal": 100,
      "unlocked": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Separate Unlocked & Locked Achievements
    List<Map<String, dynamic>> unlockedAchievements = _achievements
        .where((achievement) => achievement['unlocked'] == true)
        .toList();

    List<Map<String, dynamic>> lockedAchievements = _achievements
        .where((achievement) => achievement['unlocked'] == false)
        .toList();

    return Container(
      key: _sectionKeys[1],
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(3), // Padding for border effect
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white, // Inner Background
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            const Text(
              "Achievements",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,

              ),
            ),
            const SizedBox(height: 16),

            // Unlocked Achievements Row (Badge Style)
            _buildUnlockedBadges(unlockedAchievements),
            const SizedBox(height: 20),

            // Locked Achievements List (Progress Bar)
            Column(
              children: lockedAchievements.map((achievement) {
                return _buildAchievementRow(
                  icon: achievement["icon"],
                  title: achievement["title"],
                  progress: achievement["progress"],
                  goal: achievement["goal"],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Unlocked Achievements as Badges with Gradient Border
  Widget _buildUnlockedBadges(List<Map<String, dynamic>> achievements) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: achievements.map((achievement) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(3), // Border thickness
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFfcbc1d),
                      Color(0xFFfd9c33),

                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    achievement["icon"],
                    color: MyColors.color1,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                achievement["title"],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Locked Achievements with Progress Bar and Gradient Border
  Widget _buildAchievementRow({
    required IconData icon,
    required String title,
    required int progress,
    required int goal,
  }) {
    double progressPercentage = (progress / goal).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Achievement Icon with Gradient Border
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFfcbc1d),
                  Color(0xFFfd9c33),

                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: MyColors.color1, size: 28),
            ),
          ),
          const SizedBox(width: 16),

          // Achievement Title and Progress
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Stack(
                  children: [
                    // Progress Bar Background
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.black87.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // Progress Bar Fill
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          height: 10,
                          width: constraints.maxWidth * progressPercentage,
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
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Achievement Progress Text
                Text(
                  "$progress / $goal",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
