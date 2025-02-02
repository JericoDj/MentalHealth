import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

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
      appBar: AppBar(title: const Text("Ebooks")),
      body: ListView.builder(
        itemCount: ebooks.length,
        itemBuilder: (context, index) {
          final ebook = ebooks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(
                ebook.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(ebook.author),
              leading: const Icon(Icons.book, color: Colors.blue),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () => openEbook(ebook.epubUrl),
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
