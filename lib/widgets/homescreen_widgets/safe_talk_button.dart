import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/homescreen/safe_space/safetalk.dart';
import '../../utils/constants/colors.dart';

class SafeTalkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => SafeTalk()),
      child: Container(
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
            children: [
              Text(
                'Safe Talk`',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.color1),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Connect with specialist',
                style: TextStyle(fontSize: 14, color: MyColors.color1,),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
