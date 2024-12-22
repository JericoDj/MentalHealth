import 'package:flutter/material.dart';

class ConsultationStatusWidget extends StatefulWidget {
  @override
  _ConsultationStatusWidgetState createState() =>
      _ConsultationStatusWidgetState();
}

class _ConsultationStatusWidgetState extends State<ConsultationStatusWidget> {
  String displayText = "Consultation Overview";

  void updateDisplay(String text) {
    setState(() {
      displayText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.greenAccent.withOpacity(0.5),
            Colors.blueAccent.withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon buttons for status selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatusIcon(
                icon: Icons.request_page,
                label: "Requests",
                onTap: () {
                  updateDisplay("Requests: \nYou have 5 pending requests.");
                },
              ),
              _buildStatusIcon(
                icon: Icons.schedule,
                label: "Scheduled",
                onTap: () {
                  updateDisplay(
                      "Scheduled: \nYou have 3 consultations scheduled.");
                },
              ),
              _buildStatusIcon(
                icon: Icons.check_circle,
                label: "Finished",
                onTap: () {
                  updateDisplay(
                      "Finished: \nYou have completed 10 consultations.");
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Display Container for selected status
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Text(
                displayText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build the status icons with labels
  Widget _buildStatusIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

