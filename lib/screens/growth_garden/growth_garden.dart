import 'package:flutter/material.dart';

class GrowthGardenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section (Optional)
              _buildHeroSection(),
              const SizedBox(height: 30),

              // Section 1: Gratitude Journaling
              GratitudeJournalingContainer(),
              const SizedBox(height: 30),

              // Section 2: Insight Quest Button
              InsightQuestButton(),
              const SizedBox(height: 30),

              // Section 3: Grid View of Wellness Tools
              const Text(
                "Quick Wellness Tools",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
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
              const SizedBox(height: 30),

              // Section 4: Thrive Guide / Customized Plans
              const Text(
                "Customized Plans",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              CustomizedPlansContainer(),
            ],
          ),
        ),
      ),
    );
  }

  // Hero Section (Optional)
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Welcome to Your Growth Garden",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Nurture your mental wellness with small daily actions.",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),

        ],
      ),
    );
  }
}

// Gratitude Journaling Section
class GratitudeJournalingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Gratitude Journaling',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () => _showJournalDialog(context),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Click here to reflect on three things you are grateful for today.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
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
          title: const Text('Add to Gratitude Journal'),
          content: const TextField(
            decoration: InputDecoration(hintText: 'Write something you are grateful for...'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

// Separate Button for Insight Quest
class InsightQuestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(Icons.psychology, size: 40, color: Colors.blue),
        title: const Text(
          'Insight Quest',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Science-based quizzes to boost your insights.',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        onTap: () {
          // Navigate to Insight Quest Page
        },
      ),
    );
  }
}

// Grid Feature Card
class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final Color? color;

  const FeatureCard({
    required this.title,
    required this.icon,
    required this.description,
    this.color,
  });

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
            children: [
              Icon(icon, size: 50, color: Colors.grey[800]),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }
}

// Customized Plans Section
class CustomizedPlansContainer extends StatelessWidget {
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
              'Your Customized Plan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Daily guided activities tailored to your wellness journey.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Customize Plan'),
              onPressed: () {},
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
}
