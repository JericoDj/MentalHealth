import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class WelcomeMessageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.5), // Padding to create a border effect
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MyColors.color1, // Light Orange
            MyColors.color1,

            Color(0xFFfcbc1d),
            Color(0xFFfd9c33),
             // Dark Orange
          ],
          stops: [0.0, 0.60, 0.60, 1.0], // Half green, half orange
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
      child: Container(
        
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white, // White background for inner content
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(45)), // Slightly smaller radius
        ),
        child: Column(
          children: const [
            Text(
              'Hi there! Welcome to Your Well-Being Zone',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.color1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Let\'s focus on your mental health journey together. We\'re here to support you every step of the way!',
              style: TextStyle(fontSize: 14, color: MyColors.color1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
