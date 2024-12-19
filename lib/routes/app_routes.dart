

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:llps_mental_app/routes/routes.dart';

import '../screens/onboardingscreen.dart';


class AppRoutes {
  static final pages = [

    GetPage(name: MyRoutes.onBoarding, page: () =>  OnBoardingScreen()),
  ];
}
