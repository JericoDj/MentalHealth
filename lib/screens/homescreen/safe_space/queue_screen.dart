import 'package:flutter/material.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

import 'chat_screen.dart';

class QueueScreen extends StatelessWidget {
  final String sessionType;

  const QueueScreen({Key? key, required this.sessionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: Text("Chat with Specialist$sessionType",style: TextStyle(color: MyColors.color1),),
          iconTheme: IconThemeData(color: MyColors.color1,size: 20),
          backgroundColor: Colors.black12,
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
                        Colors.orange,         // Start - Orange
                        Colors.orangeAccent,   // Stop 2 - Orange Accent
                        Colors.green,          // Stop 3 - Green
                        Colors.greenAccent,    // Stop 4 - Green Accent
                      ],
                      stops: [0.0, 0.5, 0.5, 1.0], // Define stops at 50% transition
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],

          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Icon(
                Icons.chat_bubble_outline,
                size: 100,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "You are now in the queue for a $sessionType session.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),

            // Return to Home (GestureDetector)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                decoration: BoxDecoration(
                  color: MyColors.color2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Return to Home",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Go to Chat Screen (GestureDetector)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen(sessionType: sessionType)),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                decoration: BoxDecoration(
                  color: MyColors.color1,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Go to Chat Screen",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
