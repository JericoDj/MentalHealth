import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class UserProgressSection extends StatelessWidget {
  const UserProgressSection({
    Key? key,
    required List<GlobalKey<State<StatefulWidget>>> sectionKeys,
  })  : _sectionKeys = sectionKeys,
        super(key: key);

  final List<GlobalKey<State<StatefulWidget>>> _sectionKeys;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _sectionKeys[0],
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(3), // Padding for gradient border effect
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
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
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white, // Inner container background
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            const Text(
              "User Progress",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Progress Stats
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatCard(
                  icon: Icons.check_circle_outline,
                  value: "25",
                  label: "Check-ins",
                ),
                _buildStatCard(
                  icon: Icons.local_fire_department,
                  value: "10",
                  label: "Streak",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper Method to Build Stat Cards
  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(3), // Border padding
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.color2, width: 2),
        borderRadius: BorderRadius.circular(10),


      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white, // Inner content background
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              spacing: 5,
              children: [
                Icon(icon, color: MyColors.color1, size: 28),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
