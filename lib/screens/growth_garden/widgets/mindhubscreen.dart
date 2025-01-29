import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text('Mind Hub - $selectedCategory')),
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
