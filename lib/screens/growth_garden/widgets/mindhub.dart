import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

import 'mindhubscreen.dart';

/// A stub widget for MindHubButton.
/// Updated to match the size of InsightQuestButton.
class MindHubButton extends StatelessWidget {
  const MindHubButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width < 510
        ? MediaQuery.of(context).size.width / 2 - 30
        : 500 / 2 - 30;

    return Container(
      width: width - 5,
      height: width - 5,
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
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            // Navigate to the MindHubScreen with a default category (e.g. Articles)
            Get.to(() => const MindHubScreen(category: 'Articles'));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lightbulb, size: 36, color: Colors.grey[800]),
              const SizedBox(height: 8),
              const Text(
                'Safe Space Hub',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 3),
              const Text(
                'Feel free to explore a variety of mental health resources, including articles, videos, and eBooks, to support your self-help journey',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.black54,letterSpacing: 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
