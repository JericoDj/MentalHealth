import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/screens/homescreen/safe_space/queue_screen.dart';
import '../../../controllers/session_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../widgets/homescreen_widgets/safe_space/safe_space_bottom_buttons.dart';
import 'chat_screen.dart';

class SafeSpaceBody extends StatefulWidget {
  const SafeSpaceBody({Key? key}) : super(key: key);

  @override
  State<SafeSpaceBody> createState() => _SafeSpaceBodyState();
}

class _SafeSpaceBodyState extends State<SafeSpaceBody> {
  String? _selectedAction;

  void _navigateToChatScreen() {
    if (_selectedAction != null) {
      Get.to(() => QueueScreen(sessionType: "Safe Space"));
    } else {
      Get.snackbar(
        'Incomplete',
        'Please select an action.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: MyColors.color2.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Welcome to the 24/7 Safe Space. Connect with a specialist instantly through chat or call. We're here to help you anytime.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Chat and Call Buttons with Gradient Border
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton("chat", "Chat with\nSpecialist"),
                const SizedBox(width: 20),
                _buildActionButton("call", "Talk to\nSpecialist"),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

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
        padding: const EdgeInsets.all(2), // Creates gradient border effect
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
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
