import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  final String category;
  const QuizScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category Quiz')),
      body: Center(
        child: Text(
          "Quiz for $category Coming Soon...",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
