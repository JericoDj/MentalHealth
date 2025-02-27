import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

import '../../controllers/achievements_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/progress_controller.dart';
import '../../controllers/user_progress_controller.dart';
import '../../widgets/homescreen_widgets/safe_space.dart';
import '../../widgets/homescreen_widgets/welcome_message_section.dart';
import '../../widgets/homescreen_widgets/wellness_tracking/wellness_map.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final UserProgressController userProgressController = Get.put(UserProgressController());
  final ProgressController progressController = Get.put(ProgressController());
  final AchievementsController achievementsController = Get.put(AchievementsController());
  final HomeController homeController = Get.put(HomeController()); // ✅ Inject controller


  @override
  Widget build(BuildContext context) {
    // Fetch check-ins when HomeScreen is loaded
    userProgressController.fetchUserCheckIns();



    // ✅ Fetch achievements whenever HomeScreen is opened
    achievementsController.fetchUserAchievements();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Dashboard
              ProgressDashboardCard(),
              const SizedBox(height: 20),

              SafeSpaceSection(),
              const SizedBox(height: 20),

              // Carousel Slider Section
              CarouselSlider(
                items: [
                  _buildCarouselItem("assets/images/HomeSlider (1).jpg"),
                  _buildCarouselItem("assets/images/HomeSlider (2).jpg"),
                  _buildCarouselItem("assets/images/HomeSlider (3).jpg"),
                ],
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.easeInOut,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  viewportFraction: 0.8,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method for Carousel Items
  Widget _buildCarouselItem(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 2, color: Colors.transparent),
        gradient: LinearGradient(
          colors: [
            Color(0xFFfcbc1d),
            Color(0xFFfd9c33),
            Color(0xFFFFD700),
            Color(0xFFFFA500)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
