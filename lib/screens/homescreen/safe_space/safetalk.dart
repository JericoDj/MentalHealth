import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/screens/homescreen/safe_space/queue_screen.dart';
import 'package:llps_mental_app/test/test/pages/homePage/home_page.dart';
import 'package:llps_mental_app/test/test/test.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/safe_space/safe_space_bottom_buttons.dart';
import '../../../test/test/pages/callPage/call_page.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/storage/user_storage.dart';
import '../../../widgets/homescreen_widgets/call_customer_support_widget.dart';

class SafeTalk extends StatefulWidget {
  const SafeTalk({Key? key}) : super(key: key);

  @override
  State<SafeTalk> createState() => _SafeSpaceBodyState();
}

class _SafeSpaceBodyState extends State<SafeTalk> {
  String? _selectedAction; // Stores user's selection (Chat or Talk)
  String? userId; // Store user ID
  DocumentReference? queueRef; // Firestore reference for cleanup

  @override
  void initState() {
    super.initState();
    userId = UserStorage().getUid(); // ✅ Get user ID from local storage
  }

  // ✅ Navigate to Queue Screen & Save Request in Firestore
  // void _navigateToQueueScreen() async {
  //   if (userId == null || userId!.isEmpty) {
  //     Get.snackbar("Error", "User not found. Please log in again.");
  //     print("❌ ERROR: User ID is missing.");
  //     return;
  //   }
  //
  //   if (_selectedAction != null) {
  //     String sessionType = _selectedAction == "chat" ? "Chat" : "Talk";
  //
  //     try {
  //
  //
  //
  //       // ✅ Navigate to `CallPage` & Wait for Room ID
  //       String? newRoomId = await Get.to(() => CallPage(
  //         roomId: null,
  //         isCaller: true,
  //         sessionType: sessionType,
  //         userId: userId!,
  //       )) ?? null;
  //
  //     } catch (e) {
  //       print("❌ Firestore Write Error: $e");
  //       Get.snackbar("Error", "Failed to add request to queue: $e");
  //     }
  //   }
  // }


  void _navigateToQueueScreen() async {
    if (userId == null || userId!.isEmpty) {
      Get.snackbar("Error", "User not found. Please log in again.");
      print("❌ ERROR: User ID is missing.");
      return;
    }

    if (_selectedAction != null) {
      String sessionType = _selectedAction == "chat" ? "chat" : "talk"; // Define session type
      String formattedSessionType =
          sessionType[0].toUpperCase() + sessionType.substring(1); // Capitalize first letter
      String collectionPath = "safe_talk/$sessionType/queue"; // Dynamic Firestore path

      try {
        // ✅ Save Request to Firestore Queue in the appropriate collection
        await FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(userId!)
            .set({
          "userId": userId,
          "sessionType": formattedSessionType, // Store as "Chat" or "Talk"
          "status": "queue", // Status is now "queue"
          "timestamp": FieldValue.serverTimestamp(), // Timestamp for ordering
        });

        print("✅ User added to $formattedSessionType queue");

        // ✅ Navigate to Queue Screen
        Get.to(() => QueueScreen(
          sessionType: formattedSessionType, // Pass as "Chat" or "Talk"
          userId: userId!,
        ));
      } catch (e) {
        print("❌ Firestore Write Error: $e");
        Get.snackbar("Error", "Failed to add request to queue: $e");
      }
    }
  }







  // ✅ Remove Request from Queue on Exit (Back Button or Force Stop)
  void _cancelQueueRequest() async {
    if (queueRef != null) {
      try {
        await queueRef!.delete();
        print("🗑️ Queue request removed for $userId.");
      } catch (e) {
        print("❌ Error removing request: $e");
      }
    }
  }

  @override
  void dispose() {
    _cancelQueueRequest(); // ✅ Auto-remove from queue on screen exit
    super.dispose();
  }

  // ✅ Open Customer Support Dialog
  void _openCustomerSupport() {
    showDialog(
      context: context,
      builder: (context) => CallCustomerSupportPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 65,
          title: const Text(
            'Safe Talk',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          elevation: 2,
          flexibleSpace: Stack(
            children: [
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
                        Colors.orange,
                        Colors.orangeAccent,
                        Colors.green,
                        Colors.greenAccent,
                      ],
                      stops: const [0.0, 0.5, 0.5, 1.0],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ✅ Main Body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Welcome Card
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: MyColors.color2.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "Welcome to the Safe Space.\n"
                          "Connect with a specialist instantly through chat or call.\n"
                          "We're here to help you anytime.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // ✅ Chat and Talk Options (Outlined Buttons)
                Column(
                  children: [
                    _buildActionButton("chat", "Chat with Specialist"),
                    const SizedBox(height: 15),
                    _buildActionButton("call", "Talk to Specialist"),
                  ],
                ),

                const SizedBox(height: 30),

                // ✅ Customer Support Button
                GestureDetector(
                  onTap: _openCustomerSupport,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent, width: 1),
                    ),
                    child: const Text(
                      "Need Help? Contact Customer Support",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ✅ Bottom Navigation Buttons
        bottomNavigationBar: SafeSpaceButtons(
          isFormComplete: _selectedAction != null,
          onBookSession: _navigateToQueueScreen,
          onCallSupport: _openCustomerSupport,
        ),
      ),
    );
  }

  /// **✅ Chat and Call Buttons (Outlined)**
  Widget _buildActionButton(String actionType, String label) {
    final bool isSelected = _selectedAction == actionType;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAction = actionType;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [MyColors.color1, MyColors.color2] // Active gradient
                : [Colors.black45, Colors.black54], // Default gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(2), // Gradient border effect
        child: Container(
          padding: const EdgeInsets.all(15),
          width: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black87 : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
