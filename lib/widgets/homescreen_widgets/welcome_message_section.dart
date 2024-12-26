import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class WelcomeMessageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(BorderSide(color: MyColors.color4)),
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
      child: Column(
        children: const [
          Text(
            'Hi there! Welcome to Your Well-Being Zone',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.color4),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Let\'s focus on your mental health journey together. We\'re here to support you every step of the way!',
            style: TextStyle(fontSize: 14, color: MyColors.color4),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}