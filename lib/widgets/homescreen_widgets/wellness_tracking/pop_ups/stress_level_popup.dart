import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../screens/homescreen/wellness_tracking/progress_map_screen.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/storage/user_storage.dart';

class StressLevelPopup extends StatefulWidget {
  const StressLevelPopup({Key? key}) : super(key: key);

  @override
  State<StressLevelPopup> createState() => _StressLevelPopupState();
}

class _StressLevelPopupState extends State<StressLevelPopup> {
  String? message;

  @override
  void initState() {
    super.initState();
    _loadMessage();
  }

  Future<void> _loadMessage() async {
    final result = await getAverageStressLevelMessage();
    setState(() {
      message = result;
    });
  }

  Future<String> getAverageStressLevelMessage() async {
    final userStorage = UserStorage();
    final stressData = userStorage.getStoredStressData();

    double total = 0.0;
    int count = 0;
    final now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      final date = now.subtract(Duration(days: i));
      final key = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      double value = stressData[key] ?? 0.0;
      total += value;
      count++;
    }

    final average = total / count;

    if (average < 30) {
      return "Current Stress Level: Low\n\nRecommendation:\n- Keep doing what you're doing!\n- Stay mindful and balanced.";
    } else if (average < 70) {
      return "Current Stress Level: Moderate\n\nRecommendation:\n- Try breathing exercises\n- Take a short walk\n- Listen to relaxing music.";
    } else {
      return "Current Stress Level: High\n\nRecommendation:\n- Consider journaling or talking to a specialist\n- Prioritize rest\n- Reduce screen time and stress triggers\n- *Please consider reaching out to a mental health specialist or professional for further support.*";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title with Close Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Stress Level",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Dynamic Content
            message == null
                ? const CircularProgressIndicator()
                : Text(
              message!,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),

            const SizedBox(height: 20),

            // Manage Stress Button
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Get.to(() => const ProgressMapScreen(scrollToIndex: 3));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    style: BorderStyle.solid,
                    color: MyColors.color1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                child: const Text(
                  "Manage Stress",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyColors.color1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
