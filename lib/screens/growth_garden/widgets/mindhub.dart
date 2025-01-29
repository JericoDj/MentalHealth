import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/screens/mindhub/mindhubscreen.dart';
import '../../../utils/constants/colors.dart';


class MindHubButton extends StatelessWidget {
  const MindHubButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Ensures horizontal scrolling if needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FeatureCard(
              title: 'Mind Hub',
              icon: Icons.lightbulb,
              description: 'A central hub for mental well-being resources.',
              onTap: () {
                _showMindHubDialog(context);
              },
              width: MediaQuery.of(context).size.width < 510
                  ? MediaQuery.of(context).size.width / 2 - 30
                  : 510 / 2 - 30,
            ),
          ],
        ),
      ),
    );
  }

  void _showMindHubDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose a Category', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _categoryItem(
                    context,
                    icon: Icons.article,
                    label: 'Articles',
                    color: Colors.blue,
                    onTap: () => Get.to(() => const MindHubScreen(category: 'Articles')),
                  ),
                  _categoryItem(
                    context,
                    icon: Icons.video_collection,
                    label: 'Videos',
                    color: Colors.red,
                    onTap: () => Get.to(() => const MindHubScreen(category: 'Videos')),
                  ),
                  _categoryItem(
                    context,
                    icon: Icons.book,
                    label: 'Ebooks',
                    color: Colors.green,
                    onTap: () => Get.to(() => const MindHubScreen(category: 'Ebooks')),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _categoryItem(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 5),
            Text(label),
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
