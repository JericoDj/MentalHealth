import 'package:flutter/material.dart';

class BreathAwarenessMeditationScreen extends StatelessWidget {
  const BreathAwarenessMeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Breath Awareness Meditation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Focus on your breath', style: TextStyle(fontSize: 24)),
            const Text('Observe it without controlling.', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
