import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class InsightQuestButton extends StatelessWidget {
  const InsightQuestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width/2.2,

        child: FeatureCard(
          title: 'Insight Quest',
          icon: Icons.psychology,
          description: 'Science-based quizzes to boost your insights.',
          color: Colors.white,
          onTap: () {
            // Navigate to Insight Quest Screen using GetX
            Get.to(() => const InsightQuestScreen());
          },
          width: double.infinity,  // Full width inside the centered container
        ),
      ),
    );
  }
}

// Reusing the FeatureCard Design
class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final Color? color;
  final VoidCallback onTap;
  final double width;

  const FeatureCard({
    required this.title,
    required this.icon,
    required this.description,
    this.color,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(width: 1, color: MyColors.color1)),
        color: color ?? Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),  // Larger padding for bigger card
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: MyColors.color1.withOpacity(0.95)),  // Larger icon
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: MyColors.color1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: MyColors.color1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder for Insight Quest Screen
class InsightQuestScreen extends StatelessWidget {
  const InsightQuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insight Quest')),
      body: const Center(child: Text('Insight Quest Content Goes Here')),
    );
  }
}
