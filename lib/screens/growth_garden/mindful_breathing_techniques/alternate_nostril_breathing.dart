import 'dart:async';
import 'package:flutter/material.dart';

class AlternateNostrilBreathingScreen extends StatefulWidget {
  const AlternateNostrilBreathingScreen({super.key});

  @override
  _AlternateNostrilBreathingScreenState createState() => _AlternateNostrilBreathingScreenState();
}

class _AlternateNostrilBreathingScreenState extends State<AlternateNostrilBreathingScreen> {
  late Timer _timer;
  int _stepIndex = 0;
  bool _isPlaying = false;

  final List<String> _breathingSteps = [
    'Inhale Left Nostril',
    'Exhale Right Nostril',
    'Inhale Right Nostril',
    'Exhale Left Nostril',
  ];

  double _circleSize = 100.0;

  void _startBreathing() {
    setState(() {
      _isPlaying = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_isPlaying) return;

      setState(() {
        _circleSize = (_stepIndex == 0 || _stepIndex == 2) ? 200.0 : 100.0;
        _stepIndex = (_stepIndex + 1) % _breathingSteps.length;
      });
    });
  }

  void _togglePause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alternate Nostril Breathing")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_breathingSteps[_stepIndex], style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              width: _circleSize,
              height: _circleSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purpleAccent,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isPlaying ? _togglePause : _startBreathing,
              child: Text(_isPlaying ? 'Pause' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }
}
