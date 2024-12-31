import 'package:flutter/material.dart';

class QuickWellnessTools extends StatelessWidget {
  const QuickWellnessTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FeatureCard(
                title: 'Mindful Breathing',
                icon: Icons.air,
                description: 'Guided breathing exercises to calm the mind.',
                color: Colors.cyan[100],
                onTap: () => _showBreathingDialog(context),
                width: MediaQuery.of(context).size.width / 2 - 25,
              ),
              FeatureCard(
                title: 'Quick Meditation',
                icon: Icons.self_improvement,
                description: 'A 5-minute mindfulness session.',
                color: Colors.purple[100],
                onTap: () => _showMeditationDialog(context),
                width: MediaQuery.of(context).size.width / 2 - 25,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBreathingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mindful Breathing'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Choose a breathing technique to begin.'),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.timer),
                title: const Text('4-7-8 Breathing'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.square),
                title: const Text('Box Breathing'),
                onTap: () {},
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MindfulBreathingPage(),
                  ),
                );
              },
              child: const Text('Start'),
            ),
          ],
        );
      },
    );
  }

  void _showMeditationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quick Meditation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select a meditation theme to proceed.'),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.nightlight),
                title: const Text('Stress Relief'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.light),
                title: const Text('Gratitude Practice'),
                onTap: () {},
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuickMeditationPage(),
                  ),
                );
              },
              child: const Text('Start'),
            ),
          ],
        );
      },
    );
  }
}

// Grid Feature Card
class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final Color? color;
  final VoidCallback onTap;
  final double width;

  const FeatureCard({
    required this.title,
    required this.icon,
    required this.description,
    this.color,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: color ?? Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 36, color: Colors.grey[800]),
                const SizedBox(height: 10),
                Text(
                  title,
                  style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MindfulBreathingPage extends StatelessWidget {
  const MindfulBreathingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mindful Breathing')),
      body: const Center(child: Text('Breathing Exercise Session')),
    );
  }
}

class QuickMeditationPage extends StatelessWidget {
  const QuickMeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Meditation')),
      body: const Center(child: Text('Meditation Session Begins Here')),
    );
  }
}