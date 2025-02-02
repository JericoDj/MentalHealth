import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class BodyScanMeditationScreen extends StatefulWidget {
  const BodyScanMeditationScreen({super.key});

  @override
  _BodyScanMeditationScreenState createState() => _BodyScanMeditationScreenState();
}

class _BodyScanMeditationScreenState extends State<BodyScanMeditationScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=z8zX-QbXIT4")!,
      flags: const YoutubePlayerFlags(
        autoPlay: true, // Auto-plays when the screen is opened
        mute: false,
        loop: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🟢 Updated: White background
      appBar: AppBar(

        toolbarHeight: 65,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF8F8F8),
                    Color(0xFFF1F1F1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            /// Gradient Bottom Border
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 2, // Border thickness
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange, // Start - Orange
                      Colors.orangeAccent, // Stop 2 - Orange Accent
                      Colors.green, // Stop 3 - Green
                      Colors.greenAccent, // Stop 4 - Green Accent
                    ],
                    stops: const [0.0, 0.5, 0.5, 1.0],
                    // Define stops at 50% transition
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: const Text("Body Scan Meditation"),
        backgroundColor: Colors.white, // 🟢 Updated: White app bar
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black), // Black back button
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🌿 Welcome Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Welcome to Body Scan Meditation",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MyColors.color1),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Follow this 5-minute guided meditation to relax and restore your mind.",
                    style: TextStyle(fontSize: 16, color: Colors.black87), // 🟢 Updated: Shades of black
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // 🎥 YouTube Video Player (16:9 Aspect Ratio)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)], // 🟢 Updated: Subtle shadow
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: MyColors.color2,
                  progressColors: ProgressBarColors(
                    playedColor: MyColors.color2,
                    handleColor: MyColors.color1,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🧘‍♂️ Informational Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What is Body Scan Meditation?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.color1),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Body Scan Meditation is a mindfulness technique that helps you become aware of different parts of your body, reducing stress and improving relaxation.",
                    style: TextStyle(fontSize: 16, color: Colors.black87), // 🟢 Updated: Shades of black
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "How Can It Help?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.color1),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "• Reduces stress and anxiety\n"
                        "• Improves sleep quality\n"
                        "• Enhances self-awareness\n"
                        "• Promotes relaxation",
                    style: TextStyle(fontSize: 16, color: Colors.black87), // 🟢 Updated: Shades of black
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
