import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/widgets/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/homescreen/homescreen.dart';
import '../screens/loginscreen.dart';
import '../screens/onboardingscreen.dart';



class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onReady() async {
    super.onReady();

    // Bind the stream to listen to auth changes
    firebaseUser.bindStream(_auth.authStateChanges());

    // Remove the splash screen
    FlutterNativeSplash.remove();

    // Redirect to the appropriate screen
    await _screenRedirect();
  }

  // Function to check first-time open and redirect accordingly
  Future<void> _screenRedirect() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if it's the first time the app is opened
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // If first time, set flag to false and redirect to OnboardingScreen
      await prefs.setBool('isFirstTime', false);
      Get.offAll(() => OnBoardingScreen());
    } else {
      // If not first time, check for user authentication
      if (_auth.currentUser != null) {
        // User is logged in, redirect to HomeScreen
        Get.offAll(() => NavigationBarMenu(dailyCheckIn: true));
      } else {
        // No user logged in, redirect to LoginScreen
        Get.offAll(() => LoginScreen());
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String username,
    required String fullName,
    required String password,
  }) async {
    try {
      // Simulate API call (Replace with actual authentication logic)
      await Future.delayed(const Duration(seconds: 2));

      // Success message
      Get.snackbar(
        'Success',
        'Account created successfully!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign-up failed. Please try again!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  // SIGN IN METHOD
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("User signed in successfully");
      Get.offAll(() => HomeScreen());
    } on FirebaseAuthException catch (e) {
      print("Error during sign in: ${e.message}");
    }
  }

  // SIGN OUT METHOD
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("User signed out successfully");
      Get.offAll(() => LoginScreen());
    } catch (e) {
      print("Error during sign out: $e");
    }
  }

  // RESET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Password reset email sent");
    } on FirebaseAuthException catch (e) {
      print("Error sending reset email: ${e.message}");
    }
  }
}
