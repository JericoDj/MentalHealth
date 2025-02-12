import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/storage/user_storage.dart';
import '../../widgets/navigation_bar.dart';

class LoginController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserStorage _userStorage = UserStorage(); // Use the storage class

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs; // Show a loading indicator during login

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter both email and password",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      // Check if the email exists in Firestore
      var userQuery = await _firestore.collection("users").where("email", isEqualTo: email).get();

      if (userQuery.docs.isEmpty) {
        Get.snackbar("Error", "Account not found. Please check your email.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
        isLoading.value = false;
        return;
      }

      // Get user data
      var userData = userQuery.docs.first.data();

      // Validate password
      if (userData["password"] != password) {
        Get.snackbar("Error", "Incorrect password. Please try again.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
        isLoading.value = false;
        return;
      }

      // Save UID in GetStorage via UserStorage class
      _userStorage.saveUid(userData["uid"]);

      // Navigate to the main dashboard
      Get.offAll(() => NavigationBarMenu(dailyCheckIn: true));

      Get.snackbar("Success", "Login successful!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
