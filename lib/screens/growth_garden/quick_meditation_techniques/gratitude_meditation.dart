import 'package:flutter/material.dart';
import 'dart:async';

class GratitudeMeditationScreen extends StatefulWidget {
  const GratitudeMeditationScreen({super.key});

  @override
  _GratitudeMeditationScreenState createState() => _GratitudeMeditationScreenState();
}

class _GratitudeMeditationScreenState extends State<GratitudeMeditationScreen> {
  Timer? _timer;
  int _start = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(() {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start = _start - 1;
        }
      }),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gratitude Meditation")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Think of three things you are grateful for.', style: TextStyle(fontSize: 24)),
              const Text('Reflect and appreciate them.', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Text('Time Remaining: $_start seconds'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _start = 300; // 5 minutes timer
                  });
                  startTimer();
                },
                child: const Text('Start Meditation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
