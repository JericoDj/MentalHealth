import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class QuickWellnessTools extends StatelessWidget {
  const QuickWellnessTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Ensures horizontal scrolling if needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centers content
          children: [
            FeatureCard(
              title: 'Mindful Breathing',
              icon: Icons.air,
              description: 'Guided breathing exercises to calm the mind.',
              onTap: () {},
              width: MediaQuery.of(context).size.width < 510
                  ? MediaQuery.of(context).size.width / 2 - 30
                  : 500 / 2 - 30,
            ),
            const SizedBox(width: 15), // Spacing between cards
            FeatureCard(
              title: 'Quick Meditation',
              icon: Icons.self_improvement,
              description: 'A 5-minute mindfulness session.',
              onTap: () {},
              width: MediaQuery.of(context).size.width < 510
                  ? MediaQuery.of(context).size.width / 2 - 30
                  : 500 / 2 - 30,
            ),
          ],
        ),
      ),
    );
  }
}

// 🌟 **Feature Card with a Single Container Gradient Border**
class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final VoidCallback onTap;
  final double width;

  const FeatureCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width -15,
      height: width -15,
      padding: const EdgeInsets.all(3), // Border thickness
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.green,
            MyColors.color1,
            Colors.orange,
            MyColors.color2,
          ],
          stops: [0.0, 0.5, 0.51, 1.0], // Ensures exact half-split
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.grey[800]),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
