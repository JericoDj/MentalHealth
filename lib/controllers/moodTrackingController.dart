import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/storage/user_storage.dart';
import '../widgets/homescreen_widgets/wellness_tracking/pop_ups/daily_mood_popup.dart';

class MoodTrackingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserStorage _storage = UserStorage(); // Local storage instance

  var isSaving = false.obs; // Loading state
  var userMoods = <String, String>{}.obs; // Reactive map for storing moods (Day -> Emoji)

  // Save Mood & Stress Level to Firestore
  Future<void> saveMoodTracking(String mood, int stressLevel) async {
    String? uid = _storage.getUid(); // Get current user UID from local storage

    if (uid == null) {
      Get.snackbar("Error", "User ID not found. Please log in again.");
      return;
    }

    String todayDate = DateTime.now().toIso8601String().split('T')[0]; // YYYY-MM-DD format
    String moodEmoji = getMoodEmoji(mood); // Convert mood to emoji

    isSaving.value = true; // Show loading indicator

    try {
      await _firestore.collection("users").doc(uid)
          .collection("moodTracking")
          .doc(todayDate)
          .set({
        "mood": mood,
        "moodEmoji": moodEmoji, // Store the emoji representation in Firestore
        "stressLevel": stressLevel,
        "timestamp": Timestamp.now(),
      });

      // Update local state to reflect the new mood immediately
      userMoods[getDayOfWeek(todayDate)] = moodEmoji; // ✅ Store the emoji instead of text

      Get.snackbar("Success", "Mood tracking saved successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to save mood tracking: $e");
    } finally {
      isSaving.value = false; // Hide loading indicator
    }
  }

  Future<void> fetchUserMoodDataForCurrentWeek() async {
    String? uid = _storage.getUid();
    if (uid == null) return;

    try {
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday of this week
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday of this week

      print("DEBUG: Fetching moods from ${startOfWeek.toIso8601String()} to ${endOfWeek.toIso8601String()}");

      var snapshot = await _firestore
          .collection("users")
          .doc(uid)
          .collection("moodTracking")
          .where("timestamp", isGreaterThanOrEqualTo: Timestamp.fromDate(startOfWeek))
          .where("timestamp", isLessThanOrEqualTo: Timestamp.fromDate(endOfWeek))
          .orderBy("timestamp", descending: true)
          .get(); // Fetch moods only for this week

      if (snapshot.docs.isEmpty) {
        print("DEBUG: No mood data found for this week.");
        Get.snackbar("No Data", "No mood data found for this week.");
        return;
      }

      var newMoods = <String, String>{};

      for (var doc in snapshot.docs) {
        String date = doc.id; // YYYY-MM-DD format
        String dayOfWeek = getDayOfWeek(date); // Convert to Mon-Sun
        String mood = doc["mood"] ?? " ";
        String moodEmoji = getMoodEmoji(mood); // Convert mood to emoji

        print("DEBUG: Retrieved Mood for $dayOfWeek -> $mood ($moodEmoji)");

        newMoods[dayOfWeek] = moodEmoji; // ✅ Store the emoji representation
      }

      userMoods.clear();
      userMoods.addAll(newMoods); // Update state

      print("DEBUG: Updated Weekly Mood Data -> $userMoods");
    } catch (e) {
      print("DEBUG: Error Fetching Weekly Mood Data -> $e");
      Get.snackbar("Error", "Failed to fetch weekly mood data: $e");
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

// ✅ Convert Mood Text to Emoji
String getMoodEmoji(String mood) {
  switch (mood.toLowerCase()) { // Convert to lowercase for consistency
    case "happy":
      return "😃";
    case "neutral":
      return "😐";
    case "sad":
      return "😔";
    case "angry":
      return "😡";
    case "anxious":
      return "😰";
    default:
      return "◽️"; // Default emoji for missing data
  }
}
