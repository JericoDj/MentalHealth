import 'package:flutter/material.dart';

class CallingScreen extends StatefulWidget {
  @override
  _CallingScreenState createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  bool isMicMuted = false; // State for microphone
  bool isSpeakerMuted = false; // State for speaker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.withOpacity(0.9),
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
                  backgroundImage: NetworkImage(
                    "https://via.placeholder.com/150", // Placeholder for avatar
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Customer Support",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Calling...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
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
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(
                              isMicMuted ? Icons.mic_off : Icons.mic,
                              color: Colors.greenAccent,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isMicMuted ? "Unmute" : "Mute",
                            style: const TextStyle(
                              color: Colors.white,
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
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(
                              isSpeakerMuted ? Icons.volume_off : Icons.volume_up,
                              color: Colors.greenAccent,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isSpeakerMuted ? "Speaker Off" : "Speaker On",
                            style: const TextStyle(
                              color: Colors.white,
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
                    color: Colors.white,
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
