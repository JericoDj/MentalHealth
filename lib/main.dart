import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:llps_mental_app/repositories/authentication_repository.dart';
import 'package:llps_mental_app/screens/loginscreen.dart';
import 'package:llps_mental_app/test/test/services/webrtc_service.dart';
import 'package:llps_mental_app/test/test/test.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'controllers/achievements_controller.dart';
import 'controllers/login_controller/loginController.dart';
import 'controllers/session_controller.dart';
import 'controllers/user_progress_controller.dart';
import 'firebase_options.dart';
import 'App.dart';

// Notification Plugin Instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

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

  tz.initializeTimeZones();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );


  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS, // ✅ iOS settings added
  );


  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      debugPrint('Notification tapped with payload: ${response.payload}');
    },
  );
  // Ensure Notification Permissions for Android 13+
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();  // ✅ Correct method for v19.0.0

  Get.put(SessionController());

  if (kIsWeb) {
    Get.testMode = true;
    runApp(WebApp());
  } else {
    final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

    Get.put(WebRtcService());
    Get.put(UserProgressController());
    Get.put(LoginController());
    Get.put(AchievementsController());

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => WebRtcService()),
        ],
        child: App(), // Your main app widget
      ),
    );
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
                backgroundColor: Colors.white,
                body: Center(
                  child: Container(
                    width: 510,
                    constraints: BoxConstraints(
                      maxWidth: 500,
                    ),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: LoginScreen(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
