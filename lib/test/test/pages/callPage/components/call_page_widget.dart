import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../../../../screens/homescreen/call_ended_screen.dart';

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

  const CallPageWidget({
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
  StreamSubscription<DocumentSnapshot>? _statusSubscription;

  @override
  void initState() {
    super.initState();

    // ✅ Track Call Status in Real-Time
    _trackCallStatus();
  }

  /// ✅ Firestore Listener to Track Call Status
  void _trackCallStatus() {
    if (widget.sessionType != null && widget.userId != null) {
      String collectionPath = "safe_talk/${widget.sessionType!.toLowerCase()}/queue";

      _statusSubscription = FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(widget.userId)
          .snapshots()
          .listen((snapshot) {
        if (!snapshot.exists) return;

        var data = snapshot.data() as Map<String, dynamic>;

        if (data['status'] == 'ended') {
          // ✅ Automatically Redirect to Call Ended Screen
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CallEndedScreen(), // ✅ Navigate to Call Ended Screen
              ),
            );
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          if (!widget.connectingLoading)
            SizedBox(
              height: size.height,
              width: size.width,
              child: RTCVideoView(widget.remoteVideo, mirror: true),
            )
          else if (widget.isCaller)
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
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: size.height / 4.76,
              width: size.width / 4,
              child: RTCVideoView(widget.localVideo, mirror: true),
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
                  widget.isVideoOn ? Icons.videocam : Icons.videocam_off,
                  widget.isVideoOn ? Colors.grey.shade700 : Colors.white,
                  widget.toggleCamera,
                ),
                const SizedBox(width: 8),
                _buildButton(
                  widget.isAudioOn ? Icons.mic : Icons.mic_off,
                  widget.isAudioOn ? Colors.grey.shade700 : Colors.white,
                  widget.toggleMic,
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
      onTap: () {
        debugPrint("🚨 Leave Call button tapped!");
        onTap();
      },
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
