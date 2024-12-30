import 'package:flutter/material.dart';

class CustomizedPlansContainer extends StatefulWidget {
  @override
  _CustomizedPlansContainerState createState() => _CustomizedPlansContainerState();
}

class _CustomizedPlansContainerState extends State<CustomizedPlansContainer> {
  String selectedPlan = 'No plan selected';
  String planDescription = 'Choose a plan to start your journey.';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thrive Guide',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              selectedPlan,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
            ),
            const SizedBox(height: 10),
            Text(
              planDescription,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Choose Plan'),
              onPressed: () => _showPlanSelectionDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPlanSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a Wellness Plan'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildPlanRow(
                    'Improve Sleep',
                    'Relaxation and better sleep habits',
                    ['Wind down routine', 'Night meditation', 'Limit screen time'],
                    'Duration: 2 Weeks',
                    context
                ),
                _buildPlanRow(
                    'Manage Anxiety',
                    'Calming activities and mindfulness',
                    ['Breathing exercises', 'Gratitude journal', 'Daily grounding'],
                    'Duration: 3 Weeks',
                    context
                ),
                _buildPlanRow(
                    'Boost Productivity',
                    'Daily routines for better focus',
                    ['Pomodoro timer', 'Morning planning', 'Focus meditation'],
                    'Duration: 1 Month',
                    context
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlanRow(String title, String description, List<String> activities, String duration, BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPlan = title;
          planDescription = '$description\n$duration\nActivities:\n- ' + activities.join('\n- ');
        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: Colors.lightGreenAccent),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Activities: ${activities.join(', ')}',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    duration,
                    style: const TextStyle(fontSize: 13, color: Colors.lightGreenAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

