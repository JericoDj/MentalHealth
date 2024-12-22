import 'package:flutter/material.dart';

class GrowthGardenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GratitudeJournalingContainer(),
              SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  FeatureCard(
                    title: 'Insight Quest',
                    icon: Icons.psychology,
                    description: 'Science-based quizzes to boost your insights.',
                    color: Colors.blue[100],
                  ),
                  FeatureCard(
                    title: 'Mindful Breathing',
                    icon: Icons.air,
                    description: 'Guided breathing exercises to calm the mind.',
                    color: Colors.cyan[100],
                  ),
                  FeatureCard(
                    title: 'Quick Meditation',
                    icon: Icons.self_improvement,
                    description: 'A 5-minute mindfulness session.',
                    color: Colors.purple[100],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GratitudeJournalingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.center,
          'Gratitude Journaling',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
        ),
        SizedBox(height: 12),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () => _showJournalDialog(context),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Click here to reflect on three things you are grateful for today.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showJournalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add to Gratitude Journal'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Write something you are grateful for...'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final Color? color;

  FeatureCard({required this.title, required this.icon, required this.description, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color ?? Colors.white,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.grey[800]),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

