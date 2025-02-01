import 'dart:async';
import 'package:flutter/material.dart';

class FourSevenEightBreathingScreen extends StatefulWidget {
  const FourSevenEightBreathingScreen({super.key});

  @override
  _FourSevenEightBreathingScreenState createState() => _FourSevenEightBreathingScreenState();
}

class _FourSevenEightBreathingScreenState extends State<FourSevenEightBreathingScreen> {
  late Timer _timer;
  int _stepIndex = 0;
  bool _isPlaying = false;

  final List<String> _breathingSteps = [
    'Inhale for 4s',
    'Hold for 7s',
    'Exhale for 8s',
  ];

  final List<int> _stepDurations = [4, 7, 8];

  double _circleSize = 100.0;

  void _startBreathing() {
    setState(() {
      _isPlaying = true;
    });

    _timer = Timer.periodic(Duration(seconds: _stepDurations[_stepIndex]), (timer) {
      if (!_isPlaying) return;

      setState(() {
        _circleSize = (_stepIndex == 0) ? 200.0 : 100.0;
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
      appBar: AppBar(title: const Text("4-7-8 Breathing")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_breathingSteps[_stepIndex], style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(seconds: _stepDurations[_stepIndex]),
              width: _circleSize,
              height: _circleSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent,
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
