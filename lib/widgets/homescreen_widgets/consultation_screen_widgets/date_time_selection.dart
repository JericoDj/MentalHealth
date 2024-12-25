import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSelection extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final Function() onPickDate;
  final Function() onPickTime;

  const DateTimeSelection({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onPickDate,
    required this.onPickTime,
  }) : super(key: key);

  String _formatDate(DateTime date) =>
      DateFormat('EEE., MMM. d').format(date);

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onPickDate,
              child: Text(
                selectedDate == null
                    ? "Select Date"
                    : _formatDate(selectedDate!),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: onPickTime,
              child: Text(
                selectedTime == null
                    ? "Select Time"
                    : _formatTime(selectedTime!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
