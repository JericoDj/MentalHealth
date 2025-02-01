import 'dart:async';
import 'package:flutter/material.dart';

class BoxBreathingScreen extends StatefulWidget {
  const BoxBreathingScreen({super.key});

  @override
  _BoxBreathingScreenState createState() => _BoxBreathingScreenState();
}

class _BoxBreathingScreenState extends State<BoxBreathingScreen> {
  late Timer _timer;
  int _stepIndex = 0;
  bool _isPlaying = false;

  final List<String> _breathingSteps = [
    'Inhale for 4s',
    'Hold for 4s',
    'Exhale for 4s',
    'Hold for 4s',
  ];

  double _circleSize = 100.0;

  void _startBreathing() {
    setState(() {
      _isPlaying = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
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
      appBar: AppBar(title: const Text("Box Breathing")),
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
                color: Colors.blueAccent,
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
