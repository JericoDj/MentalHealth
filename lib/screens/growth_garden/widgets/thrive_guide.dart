import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              padding: EdgeInsets.all(5),

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
                      style: GoogleFonts.archivo(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      planDescription,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => _showPlanSelectionDialog(context),  // Handle tap event
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,  // Background color
                          borderRadius: BorderRadius.circular(12),  // Rounded corners
                          border: Border.all(
                            color: MyColors.color1,  // Border color
                            width: 2,  // Border width
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
                                fontWeight: FontWeight.bold,
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
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Wellness Plan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red, size: 24),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ..._buildPlanOptions(context),
                SizedBox(height: 15),
                _buildDialogActionButton('Cancel', () => Navigator.pop(context)),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildPlanOptions(BuildContext context) {
    return [
      _buildPlanCard(
        context,
        title: 'Improve Sleep',
        description: 'Relaxation and better sleep habits',
        activities: ['Wind down routine', 'Night meditation', 'Limit screen time'],
        duration: 'Duration: 2 Weeks',
      ),
      SizedBox(height: 10),
      _buildPlanCard(
        context,
        title: 'Manage Anxiety',
        description: 'Calming activities and mindfulness',
        activities: ['Breathing exercises', 'Gratitude journal', 'Daily grounding'],
        duration: 'Duration: 3 Weeks',
      ),
      SizedBox(height: 10),
      _buildPlanCard(
        context,
        title: 'Boost Productivity',
        description: 'Daily routines for better focus',
        activities: ['Pomodoro timer', 'Morning planning', 'Focus meditation'],
        duration: 'Duration: 1 Month',
      ),
    ];
  }

  Widget _buildPlanCard(
      BuildContext context, {
        required String title,
        required String description,
        required List<String> activities,
        required String duration,
      }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPlan = title;
          planDescription = '$description\n$duration\nActivities:\n- ${activities.join('\n- ')}';
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(description, style: TextStyle(fontSize: 14, color: Colors.black54)),
            SizedBox(height: 8),
            Text('Activities: ${activities.join(', ')}',
                style: TextStyle(fontSize: 13, color: Colors.black54)),
            SizedBox(height: 8),
            Text(duration,
                style: TextStyle(fontSize: 13, color: MyColors.color1, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogActionButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MyColors.color1, width: 2),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: MyColors.color1,
          ),
        ),
      ),
    );
  }
}

