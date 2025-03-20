import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/storage/user_storage.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final companyIdController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// **🔹 Sign Up Function**
  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      UserStorage().clearUid(); // ✅ Clear previous stored UID

      String companyId = companyIdController.text.trim();
      String email = emailController.text.trim().toLowerCase();
      String password = passwordController.text.trim();

      print("📢 [DEBUG] Checking Firestore for company ID: $companyId");

      try {
        // **Check if Company Exists**
        var companyRef = await _firestore.collection("companies").doc(companyId).get();
        if (!companyRef.exists) {
          print("❌ [ERROR] Company ID '$companyId' does not exist!");
          Get.snackbar("Error", "Company ID does not exist.",
              backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }
        print("✅ [SUCCESS] Company ID '$companyId' found in Firestore!");

        // **Check if the Email Exists in the Users Sub-Collection of the Company**
        var usersRef = _firestore.collection("companies").doc(companyId).collection("users");
        var userSnapshot = await usersRef.where('email', isEqualTo: email).get();

        if (userSnapshot.docs.isEmpty) {
          // **User does NOT exist in the company's users collection → DENY SIGNUP**
          print("❌ [ERROR] Email '$email' is NOT registered under company '$companyId'!");
          Get.snackbar("Error", "Your email is not registered under this company.",
              backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }

        print("✅ [SUCCESS] User email '$email' is verified under company '$companyId'.");

        // **Check if User Already Exists in Firebase Authentication**
        User? existingUser;
        try {
          var signInMethods = await _auth.fetchSignInMethodsForEmail(email);
          if (signInMethods.isNotEmpty) {
            existingUser = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
          }
        } catch (e) {
          print("⚠️ [INFO] User does not exist in Firebase Authentication, creating new account.");
        }

        // If User Exists in Firebase Auth, Use the Existing UID
        String uid;
        if (existingUser != null) {
          uid = existingUser.uid;
          print("✅ [SUCCESS] Existing Firebase Auth User Found: UID: $uid");
        } else {
          // **Create New Account in Firebase Authentication**
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          uid = userCredential.user!.uid;
          print("🔑 [DEBUG] New Firebase Auth UID: $uid");
        }

        // ✅ Store UID Locally
        UserStorage().saveUid(uid);

        // ✅ Update User Data in Firestore (Merges data if exists)
        await usersRef.doc(uid).set({
          "uid": uid,
          "email": email,
          "username": usernameController.text.trim(),
          "fullName": fullNameController.text.trim(),
          "companyId": companyId,
          "24/7_access": false,
        }, SetOptions(merge: true));

        print("✅ [SUCCESS] User successfully saved in Firestore");

        Get.snackbar("Success", "Account created successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
      } on FirebaseAuthException catch (e) {
        print("❌ [Firebase Auth ERROR]: $e");
        Get.snackbar("Auth Error", e.message ?? "An error occurred while creating the account.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } catch (e) {
        print("❌ [ERROR] Firestore Exception: $e");
        Get.snackbar("Error", "Something went wrong: ${e.toString()}",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

}
