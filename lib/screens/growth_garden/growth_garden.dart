import 'package:flutter/material.dart';
import 'package:llps_mental_app/screens/growth_garden/widgets/gratitude_journaling_widget.dart';
import 'package:llps_mental_app/screens/growth_garden/widgets/insight_quest.dart';
import 'package:llps_mental_app/screens/growth_garden/widgets/personalized_plans.dart';
import 'package:llps_mental_app/screens/growth_garden/widgets/quick_wellness_tools.dart';

class GrowthGardenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [







                ThriveGuide(),




                const SizedBox(height: 20),

                // Section 1: Gratitude Journaling
                GratitudeJournalWidget(),

                const SizedBox(height: 0),


                // Section 3: Grid View of Wellness Tools
                QuickWellnessTools(),
                const SizedBox(height: 0),

                // Section 2: Insight Quest Button
                InsightQuestButton(),





                const SizedBox(height: 25),
                // Section 4: Thrive Guide / Customized Plans








                const SizedBox(height: 30),



              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hero Section (Optional)
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Welcome to Your Growth Garden",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Nurture your mental wellness with small daily actions.",
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),

        ],
      ),
    );
  }
}





