import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/moodTrackingController.dart';
import '../../utils/constants/colors.dart';

void showMoodDialog(BuildContext context) {
  final MoodTrackingController moodController = Get.put(MoodTrackingController());

  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (dialogContext) {
      double _stressLevel = 50.0; // Default stress level percentage
      String _selectedMood = ""; // Store the selected mood emoji
      String _moodTemp = ""; // Temporary mood selection until confirmed

      return StatefulBuilder(
        builder: (dialogContext, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title with Exit Icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("How are you feeling today?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red, size: 24),
                        onPressed: () => Navigator.pop(dialogContext),
                      ),
                    ],
                  ),
                ),

                // Mood Emojis
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMoodEmoji(dialogContext, "😃", "Happy", _moodTemp, () {
                        setState(() => _moodTemp = "Happy");
                      }),
                      _buildMoodEmoji(dialogContext, "😐", "Neutral", _moodTemp, () {
                        setState(() => _moodTemp = "Neutral");
                      }),
                      _buildMoodEmoji(dialogContext, "😔", "Sad", _moodTemp, () {
                        setState(() => _moodTemp = "Sad");
                      }),
                      _buildMoodEmoji(dialogContext, "😡", "Angry", _moodTemp, () {
                        setState(() => _moodTemp = "Angry");
                      }),
                      _buildMoodEmoji(dialogContext, "😰", "Anxious", _moodTemp, () {
                        setState(() => _moodTemp = "Anxious");
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Stress Level Section
                const Text("Stress Level", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Slider(
                      activeColor: MyColors.color2,
                      value: _stressLevel,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      label: '${_stressLevel.toStringAsFixed(0)}%',
                      onChanged: (double value) {
                        setState(() {
                          _stressLevel = value;
                        });
                      },
                    ),
                    Text(
                      '${_stressLevel.toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Confirm GestureDetector
                GestureDetector(
                  onTap: () async {
                    if (_moodTemp.isNotEmpty) {
                      _selectedMood = _moodTemp; // Set selected mood on confirm

                      await moodController.saveMoodTracking(_selectedMood, _stressLevel.toInt());

                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(
                          content: Text("You selected: $_selectedMood with Stress Level: ${_stressLevel.toStringAsFixed(0)}%"),
                          duration: const Duration(seconds: 3),
                        ),
                      );

                      Navigator.pop(dialogContext); // Close dialog on confirm
                    } else {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a mood first!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: MyColors.color1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => moodController.isSaving.value
                        ? const CircularProgressIndicator(color: Colors.white) // Show loading indicator while saving
                        : const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    },
  );
}

// Mood Emoji Selection
Widget _buildMoodEmoji(BuildContext dialogContext, String emoji, String mood, String selectedMood, VoidCallback onTap) {
  bool isSelected = selectedMood == mood;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isSelected ? MyColors.color2.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? MyColors.color2 : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: 30, color: isSelected ? Colors.black : Colors.black87),
          ),
          const SizedBox(height: 5),
          Text(
            mood,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? Colors.black : Colors.black87),
          ),
        ],
      ),
    ),
  );
}
