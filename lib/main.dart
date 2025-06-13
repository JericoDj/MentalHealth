import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:llps_mental_app/repositories/authentication_repository.dart';
import 'package:llps_mental_app/screens/loginscreen.dart';
import 'package:llps_mental_app/test/test/services/webrtc_service.dart';
import 'package:llps_mental_app/test/test/test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'controllers/achievements_controller.dart';
import 'controllers/login_controller/loginController.dart';
import 'controllers/session_controller.dart';
import 'controllers/user_progress_controller.dart';
import 'firebase_options.dart';
import 'App.dart';

// ✅ Initialize Local Notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();




/// ✅ Initialize Firebase Messaging and Notifications
Future<void> _initializeNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // ✅ Request notification permissions
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint("✅ Notifications enabled.");
  } else {
    debugPrint("❌ Notifications denied.");
  }

  // ✅ Initialize Local Notifications for Android & iOS
  const AndroidInitializationSettings androidInitializationSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings iosInitializationSettings =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      debugPrint("🔔 Notification Clicked: \${response.payload}");
    },
  );

  // ✅ Listen for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint("✅ Foreground Message: \${message.notification?.title}");
    _showNotification(message);
  });


  // ✅ Ensure APNS token is fetched for iOS
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      debugPrint("✅ APNS Token: \$apnsToken");
    } else {
      debugPrint("❌ Failed to fetch APNS token.");
    }
  }
}

/// ✅ Show local notification
Future<void> _showNotification(RemoteMessage message) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
  const AndroidNotificationDetails(
    'default_channel', 'Default Channel',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

  NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? "New Notification",
    message.notification?.body ?? "You have a new message",
    platformChannelSpecifics,
  );
}


// Helper function to catch invalid icons
Icon validateIcon(IconData iconData) {
  if (iconData.codePoint == 0) {
    debugPrint("⚠️ Invalid IconData detected: ${iconData.toString()}");
    return const Icon(Icons.error);  // Fallback to a default error icon
  }
  return Icon(iconData);
}

// ✅ Ensure this is a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("🔔 Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.request();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));




  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  // ✅ Request necessary permissions
  await _requestPermissions();



  await FirebaseMessaging.instance.requestPermission();
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      String? token = await FirebaseMessaging.instance.getToken();
      debugPrint("✅ FCM Token (iOS): $token");
    } else {
      debugPrint("⚠️ APNs token not ready yet.");
    }
  } else {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("✅ FCM Token (Android): $token");
  }



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




    // ✅ Initialize notifications
    await _initializeNotifications();




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


/// ✅ Request Permissions for Android & iOS
Future<void> _requestPermissions() async {

    await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.photos,
    ].request();

    // ✅ Request Notification Permission Separately
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
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
      themeMode: ThemeMode.light,

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
