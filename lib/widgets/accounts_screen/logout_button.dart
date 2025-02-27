import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller/loginController.dart';
import '../../utils/constants/colors.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>(); // Get the controller instance

    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: MyColors.color2, width: 2.5), // Border color
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white, // Button background
        ),
        onPressed: () {
          loginController.logout(); // ✅ Call logout function from controller
        },
        child: Text(
          'Log Out',
          style: TextStyle(
            color: MyColors.color2, // Text color
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
