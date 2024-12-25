import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final int availableCredits;
  final bool isFormComplete;
  final Function() onBookSession;
  final Function() onCallSupport;

  const BottomButtons({
    Key? key,
    required this.availableCredits,
    required this.isFormComplete,
    required this.onBookSession,
    required this.onCallSupport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = isFormComplete && availableCredits > 0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onCallSupport,
            child: const Text(
              "Call Customer Support",
              style: TextStyle(fontSize: 14, color: Colors.redAccent),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isButtonEnabled ? onBookSession : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonEnabled
                    ? Colors.green
                    : Colors.grey.withOpacity(0.5),
              ),
              child: Text(
                "Book A Session",
                style: TextStyle(
                  color: isButtonEnabled ? Colors.white : Colors.black54,  // Text color changes if greyed out
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
