import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:llps_mental_app/repositories/authentication_repository.dart';
import 'package:llps_mental_app/screens/loginscreen.dart';
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

    runApp(const App());
  }
}

class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example: Validate an icon during web app build
    validateIcon(IconData(0, fontFamily: 'MaterialIcons'));  // This triggers the warning

    return Center(
      child: Container(
        width: 600,
        height: 800,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'llps_mental_app',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
