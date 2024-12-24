import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:llps_mental_app/repositories/authentication_repository.dart';
import 'package:llps_mental_app/screens/loginscreen.dart';
import 'firebase_options.dart';
import 'App.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Conditional Web Setup
  if (kIsWeb) {
    Get.testMode = true;
    runApp(WebApp());
  } else {
    // Mobile/Non-Web Setup
    final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

    runApp(const App());
  }
}

// Web Application Class
class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 600,
        height: 750,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'llps_mental_app',
          theme: ThemeData(primarySwatch: Colors.blue),

          // Show LoginScreen at start
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
