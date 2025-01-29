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
              WelcomeMessageSection(),
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

              // // 🔥 New: Row of Buttons for Articles, Videos, eBooks
              // _buildResourceButtons(context),
              //
              // const SizedBox(height: 20),
              //
              // // Consultation Hub
              // const ConsultationTouchpointCard(),
              // const SizedBox(height: 20),
              //
              // // 24/7 Helpline
              // const SafeSpaceCard(),
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

  // 🆕 Helper Method for Resource Buttons (Articles, Videos, eBooks)
  // 🆕 Updated Resource Buttons (No Blue Background)
  Widget _buildResourceButtons(BuildContext context) {
    return Row(spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildResourceButton(
          icon: Icons.article,
          label: "Articles",
          onPressed: () {
            // TODO: Navigate to Articles Section
          },
        ),
        _buildResourceButton(
          icon: Icons.video_library,
          label: "Videos",
          onPressed: () {
            // TODO: Navigate to Videos Section
          },
        ),
        _buildResourceButton(
          icon: Icons.menu_book,
          label: "eBooks",
          onPressed: () {
            // TODO: Navigate to eBooks Section
          },
        ),
      ],
    );
  }

// 🆕 Updated Button with Transparent Background
  Widget _buildResourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(color: MyColors.color1, width: 2), // Outline border
          backgroundColor: Colors.transparent, // Transparent background
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: MyColors.color1), // Custom icon color
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: MyColors.color1, // Custom text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}