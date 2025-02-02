import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

import 'mindhubscreen.dart';

/// A stub widget for MindHubButton.
/// You can expand its design as needed.
class MindHubButton extends StatelessWidget {
  const MindHubButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the MindHubScreen with a default category (e.g. Articles)
        Get.to(() => const MindHubScreen(category: 'Articles'));
      },
      child: Container(
        width: MediaQuery.of(context).size.width < 510
            ? MediaQuery.of(context).size.width / 2 - 30
            : 510 / 2 - 30,
        height: MediaQuery.of(context).size.width < 510
            ? MediaQuery.of(context).size.width / 2 - 30
            : 510 / 2 - 30,
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
            stops: [0.0, 0.5, 0.51, 1.0],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lightbulb, size: 36, color: Colors.grey[800]),
              const SizedBox(height: 10),
              const Text(
                'Mind Hub',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'A central hub for mental well-being resources.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
