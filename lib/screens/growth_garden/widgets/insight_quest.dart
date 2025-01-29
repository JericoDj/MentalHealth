import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'QuizScreen.dart';



import '../../../utils/constants/colors.dart';



class InsightQuestButton extends StatelessWidget {
  const InsightQuestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Ensures horizontal scrolling if needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centers content
          children: [
            FeatureCard(
              title: 'Insight Quest',
              icon: Icons.psychology,
              description: 'Science-based quizzes to boost your insights.',
              onTap: () {
                Get.to(() => const InsightQuestScreen());
              },
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
      width: width - 15,
      height: width - 15,
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



class InsightQuestScreen extends StatelessWidget {
  const InsightQuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insight Quest')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Choose a Quiz Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildCategoryGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _quizCategory(
            title: 'Mindfulness',
            icon: Icons.spa,
            color: Colors.blueAccent,
            onTap: () => Get.to(() => const QuizScreen(category: 'Mindfulness')),
          ),
          _quizCategory(
            title: 'Cognitive Skills',
            icon: Icons.memory,
            color: Colors.orangeAccent,
            onTap: () => Get.to(() => const QuizScreen(category: 'Cognitive Skills')),
          ),
          _quizCategory(
            title: 'Emotional Intelligence',
            icon: Icons.favorite,
            color: Colors.redAccent,
            onTap: () => Get.to(() => const QuizScreen(category: 'Emotional Intelligence')),
          ),
          _quizCategory(
            title: 'Resilience',
            icon: Icons.shield,
            color: Colors.green,
            onTap: () => Get.to(() => const QuizScreen(category: 'Resilience')),
          ),
        ],
      ),
    );
  }

  Widget _quizCategory({required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
