import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectedDayDetails extends StatelessWidget {
  final String selectedDay;
  final String mood;

  const SelectedDayDetails({
    Key? key,
    required this.selectedDay,
    required this.mood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Details for ${DateFormat('MMM d, yyyy').format(DateTime.parse(selectedDay))}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "Mood: ",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                mood,
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Notes: Feeling good and staying productive!",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
