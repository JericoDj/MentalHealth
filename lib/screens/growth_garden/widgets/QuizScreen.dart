import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';
import '../../../data/quiz_data.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  final bool isPersonalityBased;

  const QuizScreen({
    super.key,
    required this.category,
    required this.isPersonalityBased,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int totalScore = 0;
  bool quizCompleted = false;

  @override
  Widget build(BuildContext context) {
    final quiz = quizData[widget.category];

    if (quiz == null) {
      return Scaffold(
        appBar: _buildAppBar("Quiz Not Found"),
        body: const Center(
          child: Text(
            "Error: Quiz data not available. Please check the category name.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
      );
    }

    final isPersonalityBased = quiz["isPersonalityBased"];
    final questions = quiz["questions"];

    if (quizCompleted) {
      return _buildResultsScreen();
    }

    return Scaffold(
      appBar: _buildAppBar('${widget.category} Quiz'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / questions.length,
              color: MyColors.color2,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex]["question"],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ..._buildAnswerButtons(questions[currentQuestionIndex], isPersonalityBased),
          ],
        ),
      ),
    );
  }

  /// 🎯 Builds Answer Buttons using GestureDetector with a Colored Border
  List<Widget> _buildAnswerButtons(Map<String, dynamic> question, bool isPersonalityBased) {
    return (question["answers"] as List).map<Widget>((answer) {
      return GestureDetector(
        onTap: () => _onAnswerSelected(answer, isPersonalityBased),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white, // ✅ White background
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: MyColors.color2, width: 2), // ✅ Border color 2
          ),
          child: Center(
            child: Text(
              answer["text"],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.color2),
            ),
          ),
        ),
      );
    }).toList();
  }

  /// 📌 Handles Answer Selection
  void _onAnswerSelected(Map<String, dynamic> answer, bool isPersonalityBased) {
    setState(() {
      if (isPersonalityBased) {
        totalScore += answer["score"] as int;
      } else {
        if (answer["isCorrect"] as bool) {
          totalScore += 1;
        }
      }

      if (currentQuestionIndex + 1 < quizData[widget.category]["questions"].length) {
        currentQuestionIndex++;
      } else {
        quizCompleted = true;
      }
    });
  }

  /// 🏆 Generates Results Based on Personality Quiz Scores
  Widget _buildResultsScreen() {
    String resultMessage = _getPersonalityResult();

    return Scaffold(
      appBar: _buildAppBar('${widget.category} Quiz Results'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 80, color: MyColors.color2),
              const SizedBox(height: 20),
              Text(
                resultMessage,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.color1, width: 2),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Text(
                    "Back to Quizzes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.color1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 Defines Outcome Messages Based on Score
  String _getPersonalityResult() {
    if (totalScore >= 5) {
      return "🌿 You have high mindfulness and great self-awareness!";
    } else if (totalScore >= 3) {
      return "✨ You are somewhat mindful, but could benefit from small habits like daily meditation.";
    } else {
      return "⏳ You might struggle with mindfulness. Try setting reminders to take deep breaths throughout the day.";
    }
  }

  /// 🎨 Reusable Gradient AppBar
  PreferredSizeWidget _buildAppBar(String title) {
    return AppBar(
      toolbarHeight: 65,
      flexibleSpace: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF8F8F8),
                  Color(0xFFF1F1F1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.orangeAccent,
                    Colors.green,
                    Colors.greenAccent,
                  ],
                  stops: const [0.0, 0.5, 0.5, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
      title: Text(title),
    );
  }
}
