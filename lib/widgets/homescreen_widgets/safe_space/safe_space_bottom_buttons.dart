import 'package:flutter/material.dart';

class SafeSpaceBottomButtons extends StatelessWidget {
  final VoidCallback onConfirm;

  const SafeSpaceBottomButtons({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onConfirm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          padding: const EdgeInsets.all(16),
        ),
        child: const Text(
          "Confirm and Connect",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
