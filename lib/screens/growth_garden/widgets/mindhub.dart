import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class MindHubButton extends StatelessWidget {
  const MindHubButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2.2,
        child: FeatureCard(
          title: 'Mind Hub',
          icon: Icons.lightbulb,
          description: 'A central hub for mental well-being resources.',
          color: Colors.white,
          onTap: () {
            _showMindHubDialog(context);
          },
          width: double.infinity,
        ),
      ),
    );
  }

  void _showMindHubDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose a Category',textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.to(() => const MindHubScreen(category: 'Articles')),
                      child: Column(
                        children: [
                          const Icon(Icons.article, color: Colors.blue, size: 40),
                          const SizedBox(height: 5),
                          const Text('Articles'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.to(() => const MindHubScreen(category: 'Videos')),
                      child: Column(
                        children: [
                          const Icon(Icons.video_collection, color: Colors.red, size: 40),
                          const SizedBox(height: 5),
                          const Text('Videos'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.to(() => const MindHubScreen(category: 'Ebooks')),
                      child: Column(
                        children: [
                          const Icon(Icons.book, color: Colors.green, size: 40),
                          const SizedBox(height: 5),
                          const Text('Ebooks'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(width: 1, color: MyColors.color1)),
        color: color ?? Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: MyColors.color1.withOpacity(0.95)),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: MyColors.color1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: MyColors.color1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MindHubScreen extends StatefulWidget {
  final String category;
  const MindHubScreen({Key? key, required this.category}) : super(key: key);

  @override
  _MindHubScreenState createState() => _MindHubScreenState();
}

class _MindHubScreenState extends State<MindHubScreen> {
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category;
  }

  void _changeCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mind Hub')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _changeCategory('Articles'),
                  child: const Text('Articles'),
                ),
                ElevatedButton(
                  onPressed: () => _changeCategory('Videos'),
                  child: const Text('Videos'),
                ),
                ElevatedButton(
                  onPressed: () => _changeCategory('Ebooks'),
                  child: const Text('Ebooks'),
                ),
              ],
            ),
          ),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedCategory) {
      case 'Articles':
        return const Center(child: Text('Displaying Articles...'));
      case 'Videos':
        return const Center(child: Text('Displaying Videos...'));
      case 'Ebooks':
        return const Center(child: Text('Displaying Ebooks...'));
      default:
        return const Center(child: Text('Select a category.'));
    }
  }
}
