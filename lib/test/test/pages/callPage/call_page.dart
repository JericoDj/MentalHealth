import 'package:flutter/material.dart';
import '../../../../controllers/call_controller.dart';
import '../../services/webrtc_service.dart';
import 'components/call_page_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CallPage extends StatefulWidget {
  final String? roomId;
  final bool isCaller;
  final String? sessionType;
  final String? userId;

  CallPage({
    Key? key,
    required this.roomId,
    required this.isCaller,
    this.sessionType,
    this.userId,
  }) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late CallController _callController;
  bool connectingLoading = true;
  String? _currentRoomId; // Local variable to store the room ID

  @override
  void initState() {
    super.initState();
    _currentRoomId = widget.roomId;

    // Initialize CallController
    _callController = CallController(
      fbCallService: WebRtcService(),
      onRoomIdGenerated: (newRoomId) {
        setState(() {
          _currentRoomId = newRoomId;
          print("🔥 New Room ID: $_currentRoomId");

          // ✅ Save room ID to Firestore
          _saveRoomToFirestore(newRoomId);
        });
      },
      onCallEnded: _leaveCall,
      onConnectionEstablished: _connectingLoadingCompleted, onStateChanged: () {  },
    );

    Future.delayed(const Duration(milliseconds: 100), () async {
      await _callController.openCamera();
      _callController.init(_currentRoomId);
    });
  }

  /// ✅ **Function to Save Room ID to Firestore**
  Future<void> _saveRoomToFirestore(String roomId) async {
    if (widget.sessionType == null || widget.userId == null) {
      print("❌ ERROR: Missing sessionType or userId. Cannot save room.");
      return;
    }

    String collectionPath = widget.sessionType == "Chat"
        ? "safe_talk/chat/queue"
        : "safe_talk/talk/queue";

    try {
      await FirebaseFirestore.instance.collection(collectionPath).doc(widget.userId).set({
        'sessionType': widget.sessionType,
        'userId': widget.userId,
        'roomId': roomId, // ✅ Save the generated room ID here
        'status': 'waiting',
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("🔥 Room ID Saved in Firestore: $roomId");
    } catch (e) {
      print("❌ Error saving room ID: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        leading: const SizedBox(),
        centerTitle: true,
        title: Text(
          _currentRoomId != null ? "Room ID: $_currentRoomId" : "Loading... Wait...",
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      body: CallPageWidget(
        connectingLoading: connectingLoading,
        roomId: _currentRoomId ?? "",
        remoteVideo: _callController.remoteVideo,
        localVideo: _callController.localVideo,
        leaveCall: _leaveCall,
        switchCamera: _callController.switchCamera,
        toggleCamera: _callController.toggleCamera,
        toggleMic: _callController.toggleMic,
        isAudioOn: _callController.isAudioOn,
        isVideoOn: _callController.isVideoOn,
        isCaller: widget.isCaller,
      ),
    );
  }

  void _connectingLoadingCompleted() {
    if (mounted) {
      setState(() {
        connectingLoading = false;
      });
    }
  }

  void _leaveCall() {
    if (mounted) {
      Navigator.pop(context);
      _callController.dispose();
    }
  }

  @override
  void dispose() {
    _callController.dispose();
    super.dispose();
  }
}
