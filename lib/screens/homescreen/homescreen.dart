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

  final UserProgressController userProgressController = Get.put(
      UserProgressController());
  final ProgressController progressController = Get.put(ProgressController());
  final AchievementsController achievementsController = Get.put(
      AchievementsController());
  final HomeController homeController = Get.put(
      HomeController()); // ✅ Inject controller
  final MoodController moodController = Get.put(
      MoodController()); // ✅ Inject controller

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
              const SizedBox(height: 10),

              // Carousel Slider Section
              // Wrap in a SizedBox to prevent overflow
              SizedBox(
                height: 280, // Adjust height to fit properly
                child: CarouselSlider(
                  items: [
                    _buildCarouselItem(
                        "assets/images/homescreen/Consultation.jpg", "Consultation"),
                    _buildCarouselItem(
                        "assets/images/homescreen/CoupleTherapy.jpg", "Couple Therapy"),
                    _buildCarouselItem(
                        "assets/images/homescreen/Counselling.jpg", "Counselling"),
                    _buildCarouselItem("assets/images/homescreen/Psychotherapy.jpg",
                        "Psychological Assessment")
                  ],
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.easeInOut,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    viewportFraction: 0.8,
                  ),
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
    return SizedBox(
      height: 250, // Ensures item does not exceed the available height
      child: Column(
        mainAxisSize: MainAxisSize.min, // Prevent Column from expanding unnecessarily
        children: [
          Expanded( // Ensures the image container takes available space
            child: Container(
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
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity, // Ensures proper scaling
                ),
              ),
            ),
          ),
          const SizedBox(height: 15), // Space between image and text
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
      ),
    );
  }

}
