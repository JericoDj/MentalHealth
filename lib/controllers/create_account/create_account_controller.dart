import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final companyIdController = TextEditingController(); // Added Company ID

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      String companyId = companyIdController.text.trim();
      String email = emailController.text.trim().toLowerCase();

      try {
        // **Step 1: Check if Company Exists**
        var companyRef = await _firestore.collection("companies").doc(companyId).get();

        if (!companyRef.exists) {
          Get.snackbar(
            "Error",
            "Company ID does not exist. Please enter a valid Company ID.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        // **Step 2: Check if User Email Exists in the Company's Users**
        var userCheck = await _firestore
            .collection("companies")
            .doc(companyId)
            .collection("users")
            .where("email", isEqualTo: email)
            .get();

        if (userCheck.docs.isEmpty) {
          Get.snackbar(
            "Error",
            "You are not registered under this company. Please contact your admin.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        // **Step 3: Generate Unique UID**
        String uid = _firestore.collection("users").doc().id; // Generates a unique UID

        // **Step 4: Create Account in Firestore**
        await _firestore.collection("users").doc(uid).set({
          "uid": uid, // Store UID
          "email": email,
          "username": usernameController.text.trim(),
          "fullName": fullNameController.text.trim(),
          "companyId": companyId, // Save Company ID
          "24/7_access": false, // Set this to false initially
        });

        Get.snackbar(
          "Success",
          "Account created successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          "Something went wrong: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
