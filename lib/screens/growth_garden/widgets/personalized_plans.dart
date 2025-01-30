import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class ThriveGuide extends StatefulWidget {
  @override
  _ThriveGuideState createState() => _ThriveGuideState();
}

class _ThriveGuideState extends State<ThriveGuide> {
  String selectedPlan = 'No plan selected';
  String planDescription = 'Choose a plan to start your journey.';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Color(0xFFfcbc1d),
              Color(0xFFfd9c33),
              Color(0xFF59b34d),
              Color(0xFF359d4e),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
            
              width: double.infinity,
              padding: EdgeInsets.all(10),

              child: const Text(
                textAlign: TextAlign.center,
                'Thrive Guide',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3),
              child: Container(
                
                width: double.infinity,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),

                  color: Colors.white
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    Text(
                      selectedPlan,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      planDescription,
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _showPlanSelectionDialog(context),  // Handle tap event
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,  // Background color
                          borderRadius: BorderRadius.circular(12),  // Rounded corners
                          border: Border.all(
                            color: MyColors.color1,  // Border color
                            width: 1,  // Border width
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: MyColors.color1,
                            ),
                            SizedBox(width: 8),  // Space between icon and text
                            Text(
                              'Manage Plan',
                              style: TextStyle(
                                fontSize: 14,
                                color: MyColors.color1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
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
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

