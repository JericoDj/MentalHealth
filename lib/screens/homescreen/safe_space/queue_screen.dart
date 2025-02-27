import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/screens/homescreen/safe_space/video_call_screen.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _monitorQueueStatus();
  }

  // ✅ Monitor Queue Status in Firestore (with Mounted Check)
  void _monitorQueueStatus() {
    queueSubscription = FirebaseFirestore.instance
        .collection("safe_space/chat/queue")
        .doc(widget.userId)
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;

        setState(() {
          isOngoing = data["status"] == "ongoing";
          callRoom = data["callRoom"];
        });

        if (isOngoing && callRoom != null && callRoom!.isNotEmpty) {
          print("✅ Call Room ID received: $callRoom");
          _autoJoinVideoCall(callRoom!);
        } else {
          print("⚠️ Waiting for callRoom to be assigned...");
        }
      }
    });

    _trackQueuePosition();
  }

  // ✅ Track Queue Position in Real-Time
  void _trackQueuePosition() {
    FirebaseFirestore.instance
        .collection("safe_space/chat/queue")
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

  // ✅ Automatically Join Video Call (Ensuring Call Room Exists)
  void _autoJoinVideoCall(String? roomId) {
    if (roomId != null && roomId.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        print("🎥 Auto-joining Video Call Room: $roomId");

        try {
          if (mounted) {
            print("🔥 Navigating to Video Call Screen...");

            // ✅ Navigate to VideoCallScreen with the Room ID (No Named Route)
            Get.off(() => VideoCallScreen(roomId: roomId)); // Replaces the current screen

          } else {
            print("⚠️ Widget not mounted, cannot navigate.");
          }
        } catch (e) {
          print("❌ Error navigating to video call: $e");
        }
      });
    } else {
      print("⚠️ Room ID is empty. Cannot join.");
    }
  }

  // ✅ Remove User from Queue (Only When Leaving Manually)
  void _leaveQueue() async {
    await FirebaseFirestore.instance
        .collection("safe_space/chat/queue")
        .doc(widget.userId)
        .delete();
    print("🛑 User removed from queue.");
  }

  // ✅ Detect App Close & Remove from Queue
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      print("📴 App Paused/Closed - Not removing user automatically.");
    }
  }

  @override
  void dispose() {
    queueSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _leaveQueue();
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

              // ✅ Live Queue Position Indicator
              Text(
                isOngoing
                    ? "Your session is starting! Redirecting..."
                    : "You are #$queuePosition in the queue for a ${widget.sessionType} session.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),

              // ✅ Manual Join Button (if not auto-redirected)
              if (isOngoing && callRoom != null && callRoom!.isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    _autoJoinVideoCall(callRoom!);
                  },
                  child: const Text("Join Video Call"),
                ),

              // ✅ Leave Queue Button (Only Removes When Pressed)
              GestureDetector(
                onTap: () {
                  _leaveQueue();
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Leave Queue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
