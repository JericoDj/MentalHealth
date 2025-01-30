import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../screens/loginscreen.dart';
import '../../utils/constants/colors.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: MyColors.color2, width: 2.5), // Red border
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white, // White button background
        ),
        onPressed: () {
          _performLogout(context);
        },
        child: const Text(
          'Log Out',
          style: TextStyle(
            color: MyColors.color2,  // Red text
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


  void _performLogout(BuildContext context) {

    Get.offAll(() => LoginScreen());
    // Add your logout logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully logged out.'),
        backgroundColor: Colors.redAccent,
      ),
    );
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
