import 'package:flutter/material.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class MindHubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to MindHub',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildSection('Articles', Icons.article, context),
            _buildSection('Videos', Icons.video_library, context),
            _buildSection('eBooks', Icons.book, context),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text('See More'),
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Icon(icon, size: 60, color: MyColors.color1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('$title Item $index'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
