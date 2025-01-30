import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class SafeSpaceBottomButtons extends StatelessWidget {
  final VoidCallback onConfirm;
  final Function() onCallSupport;

  const SafeSpaceBottomButtons({Key? key, required this.onConfirm,     required this.onCallSupport,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onCallSupport,
            child: const Text(
              "Connect with customer support",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: onConfirm,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: MyColors.color1,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Confirm and Connect",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 25),
        ],
      ),
    );
  }
}