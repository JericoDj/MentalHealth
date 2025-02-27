import 'package:get/get.dart';
import '../screens/homescreen/safe_space/video_call_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: '/videocall/:roomId',
      page: () {
        // ✅ Extract roomId from route arguments
        String roomId = Get.parameters['roomId'] ?? '';
        return VideoCallScreen(roomId: roomId);
      },
      transition: Transition.fadeIn, // ✅ Smooth transition
    ),
  ];
}
