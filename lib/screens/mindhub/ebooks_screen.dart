import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MindHubEbooksScreen extends StatefulWidget {
  const MindHubEbooksScreen({Key? key}) : super(key: key);

  @override
  State<MindHubEbooksScreen> createState() => _MindHubEbooksScreenState();
}

class _MindHubEbooksScreenState extends State<MindHubEbooksScreen> {
  final List<Ebook> ebooks = [
    Ebook(
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      epubUrl: 'https://www.gutenberg.org/cache/epub/1342/pg1342-images.epub',
    ),
    Ebook(
      title: 'Frankenstein',
      author: 'Mary Shelley',
      epubUrl: 'https://www.gutenberg.org/cache/epub/84/pg84-images.epub',
    ),
    Ebook(
      title: 'The Art of War',
      author: 'Sun Tzu',
      epubUrl: 'https://www.gutenberg.org/cache/epub/132/pg132-images.epub',
    ),
  ];

  Future<void> openEbook(String epubUrl) async {
    try {
      final Uri url = Uri.parse(epubUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $epubUrl');
      }
    } catch (e) {
      print('Error opening EPUB: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: ebooks.length,
        itemBuilder: (context, index) {
          final ebook = ebooks[index];
          return GestureDetector(
            onTap: () => openEbook(ebook.epubUrl),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Image Here',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ebook.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ebook.author,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Ebook {
  final String title;
  final String author;
  final String epubUrl;

  Ebook({
    required this.title,
    required this.author,
    required this.epubUrl,
  });
}