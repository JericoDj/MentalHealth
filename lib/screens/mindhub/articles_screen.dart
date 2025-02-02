import 'package:flutter/material.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class MindHubArticlesScreen extends StatelessWidget {
  const MindHubArticlesScreen({Key? key}) : super(key: key);

  final List<Article> articles = const [
    Article(
      title: "The Power of Positive Thinking",
      description: "Discover how cultivating a po csitive mindset can improve mental well-being and overall happiness. "
          " Discover how cultivating a positive mindset can improve mental well-being and overall happiness."
          " Discover how cultivating a positive mindset can improve mental well-being and overall happiness.",
      source: "https://example.com/positive-thinking",
    ),
    Article(
      title: "Daily Meditation for Stress Relief",
      description: "Learn simple meditation techniques that help reduce stress, improve focus, and enhance relaxation.",
      source: "https://example.com/meditation",
    ),
    Article(
      title: "How Sleep Affects Mental Health",
      description: "Understanding the crucial connection between quality sleep and emotional resilience.",
      source: "https://example.com/sleep-health",
    ),
    Article(
      title: "Healthy Eating for a Sharp Mind",
      description: "Explore the best foods that nourish your brain and support mental clarity.",
      source: "https://example.com/healthy-eating",
    ),
    Article(
      title: "Managing Anxiety in Everyday Life",
      description: "Practical strategies to manage anxiety and create a more balanced lifestyle.",
      source: "https://example.com/managing-anxiety",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Mental Wellness Articles",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return _buildArticleCard(context, article);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, Article article) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => _showArticleDialog(context, article),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder container instead of image
            Container(
              width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
              height: (MediaQuery.of(context).size.width * 0.9) * (9 / 16), // 16:9 aspect ratio
              margin: const EdgeInsets.all(10), // Padding from screen edges
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300], // Light gray placeholder color
              ),
              child: const Center(
                child: Text(
                  "Image here",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _truncateText(article.description, 100), // Limit description to 100 characters
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _showArticleDialog(context, article),
                        child: const Text("Read More", style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showArticleDialog(BuildContext context, Article article) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.95, // 95% of screen width
            height: 650, // Fixed height
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button at the top right
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // Placeholder image container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300], // Placeholder color
                    ),
                    child: const Center(
                      child: Text(
                        "Image here",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Article Title (Centered)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      article.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Article Description (Scrollable)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Text(
                        article.description, // Full description in dialog
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // "View Source" button at the absolute bottom
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: MyColors.color2),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Open article source (Future update)
                      },
                      child: const Text(
                        "View Source",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: MyColors.color2, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Utility function to truncate text to a specific length
  String _truncateText(String text, int maxLength) {
    return (text.length > maxLength) ? '${text.substring(0, maxLength)}...' : text;
  }
}

// Article Data Model
class Article {
  final String title;
  final String description;
  final String source; // Source link

  const Article({
    required this.title,
    required this.description,
    required this.source,
  });
}
