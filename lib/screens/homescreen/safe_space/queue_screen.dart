import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/call_controller.dart';
import '../../../test/test/pages/callPage/components/call_page_widget.dart';
import '../../../test/test/services/webrtc_service.dart';
import 'chat_screen.dart';

class QueueScreen extends StatefulWidget {
  final String sessionType;
  final String userId;

  const QueueScreen({Key? key, required this.sessionType, required this.userId}) : super(key: key);

  @override
  _QueueScreenState createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> with WidgetsBindingObserver {
  int queuePosition = 1;
  bool isOngoing = false;
  String? callRoom;
  StreamSubscription<DocumentSnapshot>? queueSubscription;
  bool _hasLeftQueue = false;
  bool _isNavigating = false;
  late CallController _callController;
  bool connectingLoading = true;
  String? _currentRoomId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _monitorQueueStatus();
    _callController = CallController(
      fbCallService: WebRtcService(),
      onRoomIdGenerated: (newRoomId) {
        setState(() {
          _currentRoomId = newRoomId;
          print("🔥 New Room ID: $_currentRoomId");
          _saveRoomToFirestore(newRoomId);
        });
      },
      onCallEnded: _leaveQueue,
      onConnectionEstablished: _connectingLoadingCompleted,
    );
  }

  void _monitorQueueStatus() {
    String collectionPath = "safe_talk/${widget.sessionType.toLowerCase()}/queue";

    queueSubscription = FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(widget.userId)
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;

        setState(() {
          isOngoing = data["status"] == "ongoing";
          callRoom = data["callRoom"];
          _currentRoomId = callRoom;
        });

        if (isOngoing && !_isNavigating && widget.sessionType.toLowerCase() == "talk") {
          _isNavigating = true;

          // ✅ Initialize Call Controller when session is ongoing
          Future.delayed(const Duration(milliseconds: 100), () async {
            await _callController.openCamera();
            _callController.init(_currentRoomId);
          });

          print("📞 Talk session ongoing - Starting CallPageWidget...");
        }
      }
    });

    _trackQueuePosition();
  }

  // ✅ Track Queue Position in Real-Time
  void _trackQueuePosition() {
    String collectionPath = "safe_talk/${widget.sessionType.toLowerCase()}/queue";

    FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("timestamp", descending: false)
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;

      int position = 1;
      for (var doc in snapshot.docs) {
        if (doc.id == widget.userId) break;
        position++;
      }

      setState(() {
        queuePosition = position;
      });
    });
  }

  // ✅ Function to Save Room ID to Firestore
  Future<void> _saveRoomToFirestore(String roomId) async {
    if (widget.sessionType.isEmpty || widget.userId.isEmpty) {
      print("❌ ERROR: Missing sessionType or userId. Cannot save room.");
      return;
    }
  }

  // ✅ Remove User from Queue
  Future<void> _leaveQueue() async {
    if (_hasLeftQueue || _isNavigating) return;
    _hasLeftQueue = true;

    try {
      String collectionPath = "safe_talk/${widget.sessionType.toLowerCase()}/queue";

      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(widget.userId)
          .delete();

      print("🛑 User removed from queue.");
    } catch (e) {
      print("❌ Error removing user from queue: $e");
    }
  }

  // ✅ Detect App Close & Remove from Queue
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if ((state == AppLifecycleState.paused || state == AppLifecycleState.detached) && !_isNavigating) {
      print("📴 App Paused or Force Closed - Removing user from queue...");
      _leaveQueue();
    }
  }

  void _connectingLoadingCompleted() {
    if (mounted) {
      setState(() {
        connectingLoading = false;
      });
    }
  }

  @override
  void dispose() {
    queueSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    if (!_isNavigating) {
      _leaveQueue();
    }

    _callController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ If Talk session is ongoing, show CallPageWidget instead
    if (isOngoing && widget.sessionType.toLowerCase() == "talk" && _currentRoomId != null) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 26, 26, 26),
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          leading: const SizedBox(),
          centerTitle: true,
          title: Text(
            "Room ID: $_currentRoomId",
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        body: CallPageWidget(
          connectingLoading: connectingLoading,
          roomId: _currentRoomId ?? "",
          remoteVideo: _callController.remoteVideo,
          localVideo: _callController.localVideo,
          leaveCall: _leaveQueue,
          switchCamera: _callController.switchCamera,
          toggleCamera: _callController.toggleCamera,
          toggleMic: _callController.toggleMic,
          isAudioOn: _callController.isAudioOn,
          isVideoOn: _callController.isVideoOn,
          isCaller: false,
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        await _leaveQueue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.sessionType} Queue"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.chat_bubble_outline,
                size: 100,
                color: Colors.orangeAccent,
              ),
              const SizedBox(height: 20),

              Text(
                isOngoing
                    ? "Your session is starting! Redirecting..."
                    : "You are #$queuePosition in the queue for a ${widget.sessionType} session.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),

              if (isOngoing && widget.sessionType.toLowerCase() == "talk" && callRoom != null)
                ElevatedButton(
                  onPressed: () {
                    _isNavigating = true;
                    setState(() {});
                  },
                  child: const Text("Join Video Call"),
                ),

              GestureDetector(
                onTap: () async {
                  await _leaveQueue();
                  if (mounted) Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
                  child: const Text("Leave Queue", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
