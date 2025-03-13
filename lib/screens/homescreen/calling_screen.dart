import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

import '../../controllers/call_controller.dart';
import '../../test/test/services/webrtc_service.dart';
import '../../widgets/navigation_bar.dart';

class CallingCustomerSupportScreen extends StatefulWidget {

  final String? roomId;
  final bool isCaller;
  final String? userId;

  CallingCustomerSupportScreen({
    Key ? key,
    required this.roomId,
    required this.isCaller,
    this.userId
}) : super(key:key);


  @override
  _CallingScreenState createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingCustomerSupportScreen> {
  late CallController _callController;
  bool isMicMuted = false; // State for microphone
  bool isSpeakerMuted = false; // State for speaker
  bool connectingLoading = true;
  String? _currentRoomId; // Local variable to store the room ID
  String? _currentUserId; // ✅ Store the logged-in user's UID

  @override
  void initState() {
    super.initState();
    _currentRoomId = widget.roomId;

    // ✅ Add Auth State Listener to track user changes and ensure UID is loaded
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _currentUserId = user.uid;
          print("✅ User ID Retrieved: $_currentUserId");
        });
      } else {
        print("❌ ERROR: User is not logged in.");
      }
    });

    // Initialize CallController
    _callController = CallController(
      fbCallService: WebRtcService(),
      onRoomIdGenerated: (newRoomId) async {
        setState(() {
          _currentRoomId = newRoomId;
          print("🔥 New Room ID: $_currentRoomId");
        });

        // ✅ Retry logic to ensure UID is ready before saving
        await _ensureUserIdIsReady();

        if (_currentUserId != null) {
          _saveRoomToFirestore(newRoomId);
        } else {
          print("❌ ERROR: UID still null when attempting to save room.");
        }
      },
      onCallEnded: _leaveCall,
      onConnectionEstablished: _connectingLoadingCompleted,
    );

    Future.delayed(const Duration(milliseconds: 100), () async {
      await _callController.openCamera();
      _callController.init(_currentRoomId);
    });
  }

// ✅ Retry Logic to Ensure UID is Ready
  Future<void> _ensureUserIdIsReady() async {
    const int maxRetries = 5;
    const Duration retryDelay = Duration(milliseconds: 500);

    int attempts = 0;

    while (_currentUserId == null && attempts < maxRetries) {
      print("⏳ Waiting for UID... (Attempt $attempts)");
      await Future.delayed(retryDelay);
      attempts++;
    }

    if (_currentUserId == null) {
      print("❌ ERROR: Failed to retrieve UID after retries.");
    } else {
      print("✅ UID Found: $_currentUserId");
    }
  }

// ✅ **Function to Save Room ID to Firestore for Customer Support**
  Future<void> _saveRoomToFirestore(String roomId) async {
    // 🔄 Attempt to retrieve UID directly if null
    _currentUserId ??= FirebaseAuth.instance.currentUser?.uid;

    if (_currentUserId == null) {
      print("❌ ERROR: UID is null. Attempting retry...");

      // Retry logic for UID retrieval
      await _ensureUserIdIsReady();

      if (_currentUserId == null) {
        print("❌ ERROR: Failed to retrieve UID even after retries.");
        return;
      }
    }

    // ✅ Proceed to save in Firestore
    String collectionPath = "customer_support/voice/sessions";


    try {
      await FirebaseFirestore.instance.collection(collectionPath).doc(_currentUserId).set({
        'sessionType': 'Customer Support',
        'userId': _currentUserId,
        'roomId': roomId,
        'status': 'waiting',
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("🔥 Room ID Saved in Firestore (Customer Support): $roomId");
    } catch (e) {
      print("❌ Error saving room ID: $e");
    }
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
      Get.off(() => NavigationBarMenu(dailyCheckIn: false,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Caller Information
            Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                    "assets/avatars/Avatar1.jpeg", // Placeholder for avatar
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Customer Support",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Calling...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),

            // Action Buttons
            Column(
              children: [
                // Mute/Speaker Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Mute Microphone
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMicMuted = !isMicMuted;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4), // Padding inside border
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: MyColors.color2, width: 2), // Border
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Icon(
                                isMicMuted ? Icons.mic_off : Icons.mic,
                                color: MyColors.color2,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isMicMuted ? "Unmute" : "Mute",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Mute Speaker
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSpeakerMuted = !isSpeakerMuted;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4), // Padding inside border
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: MyColors.color2, width: 2), // Border
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Icon(
                                isSpeakerMuted ? Icons.volume_off : Icons.volume_up,
                                color: MyColors.color2,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isSpeakerMuted ? "Speaker Off" : "Speaker On",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // End Call Button
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Mock action for ending the call
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.redAccent,
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "End Call",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
