import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

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

class MindHubVideosScreen extends StatelessWidget {
  const MindHubVideosScreen({Key? key}) : super(key: key);

  void _showVideoDialog(BuildContext context, VideoItem video) {
    showDialog(
      context: context,
      builder: (context) => VideoPlayerDialog(video: video),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              onTap: () => _showVideoDialog(context, video),
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      // Background color for the container
                      child: Center(
                        child: Text(
                          "Thumbnail here",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          video.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
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

class VideoPlayerDialog extends StatefulWidget {
  final VideoItem video;

  const VideoPlayerDialog({Key? key, required this.video}) : super(key: key);

  @override
  _VideoPlayerDialogState createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late YoutubePlayerController _youtubeController;
  late VideoPlayerController _localController;
  late bool _isYouTube;

  @override
  void initState() {
    super.initState();
    _isYouTube = widget.video.isYouTube;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    if (_isYouTube) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.video.videoUrl)!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: true,
        ),
      );
    } else {
      _localController = VideoPlayerController.network(widget.video.videoUrl)
        ..initialize().then((_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (_isYouTube) {
      _youtubeController.dispose();
    } else {
      _localController.dispose();
    }
    super.dispose();
  }

  Widget _buildVideoPlayer(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    return Stack(
      children: [
        if (_isYouTube)
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _youtubeController,
              aspectRatio: isLandscape ? 16 / 9 : 16 / 9,
            ),
            builder: (context, player) => player,
          )
        else
          _localController.value.isInitialized
              ? AspectRatio(
            aspectRatio: isLandscape
                ? _localController.value.aspectRatio
                : 16 / 9,
            child: VideoPlayer(_localController),
          )
              : const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 600,
        height: isLandscape ? MediaQuery.of(context).size.height : 400,
        child: Column(
          children: [
            // Video Player
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  _buildVideoPlayer(context),
                  // Show 'X' button only in portrait mode
                  if (!isLandscape)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white, size: 28),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                ],
              ),
            ),

            // Show Text Only in Portrait Mode
            if (!isLandscape)
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.video.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.video.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
  }

