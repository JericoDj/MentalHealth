import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoItem {
  final String title;
  final String description;
  final String thumbnail;
  final String videoUrl;
  final bool isYouTube;

  const VideoItem({
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.videoUrl,
    required this.isYouTube,
  });
}

final List<VideoItem> videos = const [
  VideoItem(
    title: "What is Mental Health?",
    description: "One in four adults experiences a diagnosable mental health problem each year. "
        "Recognizing stress is key to managing mental health issues effectively.",
    thumbnail: "https://source.unsplash.com/600x400/?mentalhealth",
    videoUrl: "https://www.youtube.com/watch?v=G0zJGDokyWQ",
    isYouTube: true,
  ),
  VideoItem(
    title: "7 Signs You Need a Mental Wellness Check",
    description: "Recognizing early signs of declining mental health can prevent severe issues. "
        "This video explains the warning signs to watch for.",
    thumbnail: "https://source.unsplash.com/600x400/?doctor,mentalhealth",
    videoUrl: "https://www.youtube.com/watch?v=ekHyJcML5N4",
    isYouTube: true,
  ),
  VideoItem(
    title: "How to Cope with Anxiety | TEDx",
    description: "Anxiety affects 1 in 14 people worldwide. Olivia Remes shares strategies for managing "
        "and treating anxiety through self-care and resilience.",
    thumbnail: "https://source.unsplash.com/600x400/?anxiety,stress",
    videoUrl: "https://www.youtube.com/watch?v=WWloIAQpMcQ",
    isYouTube: true,
  ),
];

class MindHubVideosScreen extends StatefulWidget {
  const MindHubVideosScreen({Key? key}) : super(key: key);

  @override
  _MindHubVideosScreenState createState() => _MindHubVideosScreenState();
}

class _MindHubVideosScreenState extends State<MindHubVideosScreen> {
  void _showVideoDialog(BuildContext context, VideoItem video) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95, // 95% of screen width
            height: 600, // Fixed height
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exit button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // Video Player (16:9)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: video.isYouTube
                      ? YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(video.videoUrl)!,
                      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
                    ),
                    showVideoProgressIndicator: true,
                  )
                      : VideoPlayerWidget(videoUrl: video.videoUrl),
                ),
                const SizedBox(height: 10),

                // Video Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    video.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                // Full Description (Scrollable)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Text(
                        video.description,
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
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
                "Mental Health Videos",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () => _showVideoDialog(context, video),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: (MediaQuery.of(context).size.width * 0.9) * (9 / 16),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[300], // Light gray placeholder
                            ),
                            child: const Center(
                              child: Text(
                                "Thumbnail here",
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
                                  video.title,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  video.description.length > 100
                                      ? "${video.description.substring(0, 100)}..."
                                      : video.description,
                                  style: const TextStyle(fontSize: 14, color: Colors.black87),
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
            ],
          ),
        ),
      ),
    );
  }
}

// Video Player Widget (For local videos)
class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(_controller)
        : const Center(child: CircularProgressIndicator());
  }
}
