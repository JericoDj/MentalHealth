import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

import '../../widgets/homescreen_widgets/consultation_touchpoint.dart';
import '../../widgets/homescreen_widgets/safe_space.dart';
import '../../widgets/homescreen_widgets/welcome_message_section.dart';
import '../../widgets/homescreen_widgets/wellness_tracking/wellness_map.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Daily Moods Section

              // Progress Dashboard
              ProgressDashboardCard(),
              const SizedBox(height: 20),
              WelcomeMessageSection(),
              const SizedBox(height: 20),

              // Carousel Slider Section

              CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.color1, width: 2), // Border color and width
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Match border radius
                      child: Image.asset(
                        "assets/images/HomeSlider (1).jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.color1, width: 2), // Border color and width
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Match border radius
                      child: Image.asset(
                        "assets/images/HomeSlider (2).jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.color1, width: 2), // Border color and width
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Match border radius
                      child: Image.asset(
                        "assets/images/HomeSlider (3).jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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

              // Consultation Hub
              const ConsultationTouchpointCard(),
              const SizedBox(height: 20),

              // 24/7 Helpline
              const SafeSpaceCard(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method for Daily Moods
  Widget _buildMoodDay(String day, String emoji) {
    return Container(
      child: Column(
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: MyColors.color1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            emoji,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

