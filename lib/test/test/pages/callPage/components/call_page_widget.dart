import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CallPageWidget extends StatelessWidget {
  final bool connectingLoading;
  final String roomId;
  final bool isCaller;
  final RTCVideoRenderer remoteVideo;
  final RTCVideoRenderer localVideo;
  final VoidCallback leaveCall;
  final VoidCallback switchCamera;
  final VoidCallback toggleCamera;
  final VoidCallback toggleMic;
  final bool isAudioOn;
  final bool isVideoOn;
  final String? sessionType; // ✅ New: Pass session type
  final String? userId; // ✅ New: Pass user ID

  CallPageWidget({
    super.key,
    required this.connectingLoading,
    required this.roomId,
    required this.isCaller,
    required this.remoteVideo,
    required this.localVideo,
    required this.leaveCall,
    required this.switchCamera,
    required this.toggleCamera,
    required this.toggleMic,
    required this.isAudioOn,
    required this.isVideoOn,
    this.sessionType, // ✅ New
    this.userId, // ✅ New
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          if (!connectingLoading)
            SizedBox(
              height: size.height,
              width: size.width,
              child: RTCVideoView(remoteVideo, mirror: true),
            )
          else if (isCaller)
            Container(
              padding: const EdgeInsets.only(left: 20, right: 10),
              height: size.height,
              width: size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Waiting for participant...",
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Share your room ID.",
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      color: Colors.grey,
                      height: 48,
                      width: size.width - 30,
                      child: Text(
                        roomId,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: size.height / 4.76,
              width: size.width / 4,
              child: RTCVideoView(localVideo, mirror: true),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 10,
            child: Row(
              children: [
                _buildButton(Icons.call_end, Colors.red, leaveCall),
                const SizedBox(width: 16),
                _buildButton(Icons.switch_camera, Colors.grey.shade700, switchCamera),
                const SizedBox(width: 8),
                _buildButton(
                  isVideoOn ? Icons.videocam : Icons.videocam_off,
                  isVideoOn ? Colors.grey.shade700 : Colors.white,
                  toggleCamera,
                ),
                const SizedBox(width: 8),
                _buildButton(
                  isAudioOn ? Icons.mic : Icons.mic_off,
                  isAudioOn ? Colors.grey.shade700 : Colors.white,
                  toggleMic,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(1000)),
        ),
        child: Icon(icon, size: 23, color: Colors.white),
      ),
    );
  }
}
