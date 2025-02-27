import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:llps_mental_app/repositories/authentication_repository.dart';
import 'package:llps_mental_app/screens/loginscreen.dart';
import 'controllers/achievements_controller.dart';
import 'controllers/login_controller/loginController.dart';
import 'controllers/session_controller.dart';
import 'controllers/user_progress_controller.dart';
import 'firebase_options.dart';
import 'App.dart';

// Helper function to catch invalid icons
Icon validateIcon(IconData iconData) {
  if (iconData.codePoint == 0) {
    debugPrint("⚠️ Invalid IconData detected: ${iconData.toString()}");
    return const Icon(Icons.error);  // Fallback to a default error icon
  }
  return Icon(iconData);
}

Future<void> main() async {

  Get.put(SessionController()); // Ensure that SessionController is registered at the start





  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    Get.testMode = true;
    runApp(WebApp());
  } else {
    final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));



    Get.put(UserProgressController()); // Initialize UserProgressController first
    Get.put(LoginController()); // ✅ Register LoginController globally
    Get.put(AchievementsController()); // Then initialize AchievementsController


    runApp(const App());
  }
}


class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    validateIcon(Icons.error);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'llps_mental_app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Center(
          child: Container(
            width: 510,
            height: 800,

            child: GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'llps_mental_app',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: Scaffold(
    backgroundColor: Colors.white, // Match background color
    body: Center(
    child: Container(
    width: 510, // Fixed width
    constraints: BoxConstraints(
    maxWidth: 500, // Ensure width doesn't exceed 500px
    ),
    height: double.infinity, // Take full height
    decoration: BoxDecoration(
    border: Border.all(color: Colors.black, width: 2), // Optional border
    ),
    child: LoginScreen(), // Your screen content
    ),
    ),
    ))))));

  }
}
