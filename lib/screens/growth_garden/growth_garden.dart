import 'package:flutter/material.dart';
import 'package:llps_mental_app/screens/growth_garden/widgets/gratitude_journaling_widget/gratitude_journaling_widget.dart';
import 'package:llps_mental_app/screens/growth_garden/widgets/insight_quest.dart';
import 'package:llps_mental_app/screens/growth_garden/widgets/mindhub.dart';
import 'package:llps_mental_app/screens/growth_garden/widgets/quick_wellness_tools.dart';
import 'package:llps_mental_app/screens/growth_garden/widgets/thrive_guide.dart';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                ThriveGuideScreen(),

                const SizedBox(height: 15),

                // Section 3: Grid View of Wellness Tools
                QuickWellnessTools(),


                const SizedBox(height: 10),


                // Section 1: Gratitude Journaling
                GratitudeJournalWidget(),

                const SizedBox(height: 5),

                // Section 2: Insight Quest Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MindHubButton(),
                    SizedBox(width: 15,),
                    InsightQuestButton(),
                  ],
                ),






                const SizedBox(height: 5),



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





