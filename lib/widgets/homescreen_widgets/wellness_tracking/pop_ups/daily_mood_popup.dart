import 'package:flutter/material.dart';

class DailyMoodPopup extends StatelessWidget {
  final String selectedDay;
  final String mood;

  const DailyMoodPopup({
    Key? key,
    required this.selectedDay,
    required this.mood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Mood for $selectedDay"),
      content: Text(
        "Today's Mood: $mood\nNotes: 'Feeling good and productive!'",
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Close"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Navigate to mood tracking details
          },
          child: const Text("View Details"),
        ),
      ],
    );
  }
}
