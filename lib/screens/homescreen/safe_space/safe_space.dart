import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/screens/homescreen/safe_space/queue_screen.dart';

import '../../../widgets/homescreen_widgets/safe_space/safe_space_bottom_buttons.dart';
import 'chat_screen.dart';

class SafeSpaceScreen extends StatefulWidget {
  const SafeSpaceScreen({Key? key}) : super(key: key);

  @override
  State<SafeSpaceScreen> createState() => _SafeSpaceScreenState();
}

class _SafeSpaceScreenState extends State<SafeSpaceScreen> {
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
    if (_selectedSessionType != null && _selectedAction != null) {
      Get.to(() =>  QueueScreen(sessionType: _selectedSessionType!));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("24/7 Safe Space"),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButtonFormField<String>(
                value: _selectedSessionType,
                hint: const Text("Select Type of Session"),
                items: _sessionTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Row(

                      children: [
                        Text(type),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap: () => _showServiceDetails(type),
                          child: const Icon(Icons.info_outline, color: Colors.blue),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSessionType = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _selectedSessionType != null ? () {
                    setState(() {
                      _selectedAction = 'chat';
                    });
                  } : null,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedAction == 'chat' ? Colors.greenAccent : (_selectedSessionType == null ? Colors.grey : Colors.white),
                      border: Border.all(
                        color: _selectedAction == 'chat' ? Colors.white : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Chat with Specialist",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _selectedAction == 'chat' ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _selectedSessionType != null ? () {
                    setState(() {
                      _selectedAction = 'call';
                    });
                  } : null,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedAction == 'call' ? Colors.greenAccent : (_selectedSessionType == null ? Colors.grey : Colors.white),
                      border: Border.all(
                        color: _selectedAction == 'call' ? Colors.white : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Talk to Specialist",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _selectedAction == 'call' ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Available Credits: $availableCredits",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeSpaceBottomButtons(
        onConfirm: _navigateToChatScreen,
      ),
    );
  }
}

