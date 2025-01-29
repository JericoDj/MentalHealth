import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/screens/homescreen/safe_space/queue_screen.dart';
import '../../../controllers/session_controller.dart';
import '../../../widgets/homescreen_widgets/safe_space/safe_space_bottom_buttons.dart';
import 'chat_screen.dart';

class SafeSpaceBody extends StatefulWidget {
  const SafeSpaceBody({Key? key}) : super(key: key);

  @override
  State<SafeSpaceBody> createState() => _SafeSpaceBodyState();
}

class _SafeSpaceBodyState extends State<SafeSpaceBody> {
  int availableCredits = 5;
  String? _selectedSessionType;
  String? _selectedAction;

  final Map<String, String> _sessionDetails = {
    "Psychological Assessment": "Comprehensive psychological evaluation using tests and interviews.",
    "Consultation": "One-on-one discussion to address mental health concerns.",
    "Couple Therapy/Counseling": "Counseling to help couples improve communication and resolve conflicts.",
    "Counseling and Psychotherapy": "Therapy sessions to address deep-seated emotional and psychological issues."
  };

  final List<String> _sessionTypes = [
    "Psychological Assessment",
    "Consultation",
    "Couple Therapy/Counseling",
    "Counseling and Psychotherapy"
  ];
  void _navigateToChatScreen() {
    // Update the controller with selected session type and action
    final sessionController = Get.find<SessionController>();
    sessionController.selectedSessionType?.value = _selectedSessionType!;
    sessionController.selectedAction?.value = _selectedAction!;

    if (_selectedSessionType != null && _selectedAction != null) {
      Get.to(() => QueueScreen(sessionType: _selectedSessionType!));
    } else {
      Get.snackbar(
        'Incomplete',
        'Please select a session type and action.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showServiceDetails(String service) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(service),
          content: Text(_sessionDetails[service] ?? "Details not available"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showSessionSelectionPopup() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _sessionTypes.map((type) {
              return ListTile(
                title: Text(type, style: const TextStyle(fontSize: 14)),
                trailing: const Icon(Icons.info_outline, color: Colors.blue),
                onTap: () {
                  setState(() {
                    _selectedSessionType = type;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "Welcome to the 24/7 Safe Space. Connect with a specialist instantly through chat or call. We're here to help you anytime.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: _showSessionSelectionPopup,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedSessionType ?? "Select Type of Session",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.transparent),
                    ],
                  ),
                ),
              ),
            ),


            Row(
               spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _selectedSessionType != null
                      ? () {
                    setState(() {
                      _selectedAction = 'chat';
                    });
                  }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _selectedAction == 'chat'
                          ? Colors.greenAccent
                          : (_selectedSessionType == null ? Colors.grey : Colors.white),
                      border: Border.all(
                        color: _selectedAction == 'chat' ? Colors.white : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Chat with\nSpecialist",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _selectedAction == 'chat' ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _selectedSessionType != null
                      ? () {
                    setState(() {
                      _selectedAction = 'call';
                    });
                  }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _selectedAction == 'call'
                          ? Colors.greenAccent
                          : (_selectedSessionType == null ? Colors.grey : Colors.white),
                      border: Border.all(
                        color: _selectedAction == 'call' ? Colors.white : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Talk to\nSpecialist",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _selectedAction == 'call' ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),


          ],
        ),
      ),
    );
  }
}
