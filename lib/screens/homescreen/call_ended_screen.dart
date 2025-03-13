import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/navigation_bar.dart';

class CallEndedScreen extends StatelessWidget {
  const CallEndedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
        title: const Text(
          "Call Ended",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.call_end, size: 100, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text(
              "The call has ended.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.offAll(() => NavigationBarMenu(dailyCheckIn: false)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
