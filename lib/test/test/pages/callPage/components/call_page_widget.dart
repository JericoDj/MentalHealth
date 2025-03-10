import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CallPageWidget extends StatefulWidget {
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
  final String? sessionType;
  final String? userId;

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
    this.sessionType,
    this.userId,
  });

  @override
  State<CallPageWidget> createState() => _CallPageWidgetState();
}

class _CallPageWidgetState extends State<CallPageWidget> {
  late bool isAudioOn;
  late bool isVideoOn;

  @override
  void initState() {
    super.initState();
    isAudioOn = widget.isAudioOn;
    isVideoOn = widget.isVideoOn;
  }

  void toggleMic() {
    setState(() {
      isAudioOn = !isAudioOn;
    });
    widget.toggleMic();
  }

  void toggleCamera() {
    setState(() {
      isVideoOn = !isVideoOn;
    });
    widget.toggleCamera();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            if (!widget.connectingLoading)
              SizedBox(
                height: size.height,
                width: size.width,
                child: RTCVideoView(widget.remoteVideo, mirror: true),
              )
            else if (widget.isCaller)
              _buildWaitingScreen(size),

            Positioned(
              bottom: 0,
              right: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: size.height / 4.76,
                    width: size.width / 4,
                    child: RTCVideoView(widget.localVideo, mirror: true),
                  ),
                  if (!isVideoOn)
                    Container(
                      height: size.height / 4.76,
                      width: size.width / 4,
                      color: Colors.black.withOpacity(0.6),
                      child: const Center(
                        child: Icon(Icons.videocam_off, color: Colors.white, size: 32),
                      ),
                    ),
                ],
              ),
            ),

            Positioned(
              bottom: 12,
              left: 10,
              child: Row(
                children: [
                  _buildButton(Icons.call_end, Colors.red, widget.leaveCall),
                  const SizedBox(width: 16),
                  _buildButton(Icons.switch_camera, Colors.grey.shade700, widget.switchCamera),
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
      ),
    );
  }

  Widget _buildWaitingScreen(Size size) {
    return Container(
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
                widget.roomId,
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