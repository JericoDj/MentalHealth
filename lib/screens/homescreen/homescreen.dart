import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/controllers/MoodController.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/wellness_tracking/moods_section.dart';

import '../../controllers/achievements_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/progress_controller.dart';
import '../../controllers/user_progress_controller.dart';
import '../../widgets/homescreen_widgets/safe_talk_button.dart';
import '../../widgets/homescreen_widgets/wellness_tracking/wellness_map.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final UserProgressController userProgressController = Get.put(UserProgressController());
  final ProgressController progressController = Get.put(ProgressController());
  final AchievementsController achievementsController = Get.put(AchievementsController());
  final HomeController homeController = Get.put(HomeController()); // ✅ Inject controller
  final MoodController moodController = Get.put(MoodController()); // ✅ Inject controller

  @override
  Widget build(BuildContext context) {

    moodController.getWeeklyMoods();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Progress Dashboard
              ProgressDashboardCard(),
              const SizedBox(height: 20),

              SafeTalkButton(),
              const SizedBox(height: 20),

              // Carousel Slider Section
              CarouselSlider(
                items: [
                  _buildCarouselItem("assets/images/homescreen/Consultation.jpg", "Consultation"),
                  _buildCarouselItem("assets/images/homescreen/Counselling.jpg", "Counselling"),
                  _buildCarouselItem("assets/images/homescreen/CoupleTherapy.jpg", "Couple Therapy"),
                  _buildCarouselItem("assets/images/homescreen/PsychologicalAssessment.jpg", "Psychological Assessment")
                ],
                options: CarouselOptions(
                  height: 280.0, // Increased height to accommodate text
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
  Widget _buildCarouselItem(String imagePath, String title) {
    return Column(
      children: [
        Container(
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
        ),
        const SizedBox(height: 8),  // Space between image and text

        // Text below the image
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
