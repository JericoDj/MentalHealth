import 'package:flutter/material.dart';

class BodyScanMeditationScreen extends StatelessWidget {
  const BodyScanMeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Body Scan Meditation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Focus on different body parts', style: TextStyle(fontSize: 24)),
            const Text('Start from head to toe.', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
