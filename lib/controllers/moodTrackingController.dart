import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/storage/user_storage.dart';
import '../widgets/homescreen_widgets/wellness_tracking/pop_ups/daily_mood_popup.dart';

class MoodTrackingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserStorage _storage = UserStorage(); // Local storage instance

  var isSaving = false.obs; // Loading state
  var userMoods = <String, String>{}.obs; // Reactive map for storing moods

  // Save Mood & Stress Level to Firestore
  Future<void> saveMoodTracking(String mood, int stressLevel) async {
    String? uid = _storage.getUid(); // Get current user UID from local storage

    if (uid == null) {
      Get.snackbar("Error", "User ID not found. Please log in again.");
      return;
    }

    String todayDate = DateTime.now().toIso8601String().split('T')[0]; // YYYY-MM-DD format

    isSaving.value = true; // Show loading indicator

    try {
      await _firestore.collection("users").doc(uid)
          .collection("moodTracking")
          .doc(todayDate)
          .set({
        "mood": mood,
        "stressLevel": stressLevel,
        "timestamp": Timestamp.now(),
      });

      // Update local state to reflect the new mood immediately
      userMoods[getDayOfWeek(todayDate)] = mood;

      Get.snackbar("Success", "Mood tracking saved successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to save mood tracking: $e");
    } finally {
      isSaving.value = false; // Hide loading indicator
    }
  }

  Future<void> fetchUserMoodData() async {
    String? uid = _storage.getUid();
    if (uid == null) return;

    try {
      var snapshot = await _firestore
          .collection("users")
          .doc(uid)
          .collection("moodTracking")
          .orderBy("timestamp", descending: true)
          .get(); // Fetch all mood records

      if (snapshot.docs.isEmpty) {
        Get.snackbar("No Data", "No mood data found.");
        return;
      }

      var newMoods = <String, String>{};

      for (var doc in snapshot.docs) {
        String date = doc.id; // Use document ID (YYYY-MM-DD)
        String dayOfWeek = getDayOfWeek(date); // Convert to Mon-Sun
        String mood = doc["mood"] ?? " "; // Default to neutral if missing

        newMoods[dayOfWeek] = getMoodEmoji(mood); // Convert mood to emoji
      }

      userMoods.clear();
      userMoods.addAll(newMoods); // Update reactive state

      print("Fetched moods: $newMoods"); // Debugging logs
      Get.snackbar("Success", "Mood data loaded successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch mood data: $e");
    }
  }


  // Show Mood Popup when Clicking on a Day
  void showDailyMoodPopup(String day, String mood, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DailyMoodPopup(
        mood: mood,
        selectedDay: day,
      ),
    );
  }

  // Convert Date (YYYY-MM-DD) to Weekday Name (Mon-Sun)
  String getDayOfWeek(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][parsedDate.weekday % 7];
    } catch (e) {
      return "Unknown";
    }
  }
}

String getMoodEmoji(String mood) {
  switch (mood.toLowerCase()) {
    case "happy":
      return "😊";
    case "sad":
      return "😢";
    case "neutral":
      return "😐";
    case "angry":
      return "😡";
    case "anxious":
      return "😰";
    default:
      return " "; // Default to empty if no mood data
  }
}

