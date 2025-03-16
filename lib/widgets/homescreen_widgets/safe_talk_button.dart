import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/homescreen/safe_space/safetalk.dart';
import '../../utils/constants/colors.dart';

class SafeTalkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => Get.to(() => SafeTalk()),
        child: Container(
          width: 200,

          padding: const EdgeInsets.all(2.5), // Padding to create a border effect
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: MyColors.color2
          ),
          child: Container(


            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: MyColors.color2

            ),
            child: Column(
              children: [
                Text(
                  'Safe Talk',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.white),
                  textAlign: TextAlign.center,
                ),

                Text(
                  'Connect with specialist',
                  style: TextStyle(fontSize: 14, color: MyColors.white,),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
