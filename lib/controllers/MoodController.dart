import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../utils/storage/user_storage.dart';
import 'package:intl/intl.dart';

class MoodController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserStorage _storage = UserStorage();

  var selectedPeriod = "Weekly".obs; // Default selection
  var moodData = <String, int>{}.obs; // Mood frequency counts
  var dailyMoods = <String, String>{}.obs; // Mood per day

  final List<String> _allMoods = ["Happy", "Neutral", "Sad", "Angry", "Anxious"];

  @override
  void onInit() {
    super.onInit();
    fetchUserMoods(); // Fetch data when the controller initializes
  }

  /// ✅ **Updates Selected Period & Fetches Data**
  void updatePeriod(String period) {
    selectedPeriod.value = period;
    fetchUserMoods();
  }

  /// ✅ **Fetch Moods Based on Selected Period**
  Future<void> fetchUserMoods() async {
    String? uid = _storage.getUid();
    if (uid == null) {
      print("❌ Error: UID is null");
      return;
    }

    try {
      var snapshot = await _firestore
          .collection("users")
          .doc(uid)
          .collection("moodTracking")
          .orderBy("timestamp", descending: true)
          .get();

      if (snapshot.docs.isEmpty) {
        print("⚠️ No mood data found.");
        _resetMoodCounts(); // Ensures all moods are shown even if empty
        return;
      }

      // ✅ Calculate the Date Range Based on Selected Period
      DateTime now = DateTime.now();
      DateTime startDate = _getStartDate(now, selectedPeriod.value);

      Map<String, int> newMoodCounts = {for (var mood in _allMoods) mood: 0}; // Ensure all moods exist
      Map<String, String> newDailyMoods = {};

      for (var doc in snapshot.docs) {
        var data = doc.data();
        String mood = data["Mood"] ?? "Neutral";
        String date = doc.id; // Assuming doc ID is the date

        DateTime moodDate = DateTime.parse(date);
        if (moodDate.isBefore(startDate)) continue; // Skip old moods

        newDailyMoods[date] = mood;
        newMoodCounts[mood] = (newMoodCounts[mood] ?? 0) + 1;
      }

      // ✅ Update UI with complete mood set
      dailyMoods.assignAll(newDailyMoods);
      moodData.assignAll(newMoodCounts);
      moodData.refresh();

      print("✅ Mood Data Loaded: $moodData");
    } catch (e) {
      print("❌ Firestore Error: $e");
    }
  }

  /// ✅ **Ensures All Moods are Present in Chart, Even If Empty**
  void _resetMoodCounts() {
    moodData.assignAll({for (var mood in _allMoods) mood: 0});
    moodData.refresh();
  }

  /// ✅ **Returns the Start Date Based on Selected Period**
  DateTime _getStartDate(DateTime now, String period) {
    switch (period) {
      case "Weekly":
        return now.subtract(Duration(days: 7));
      case "Monthly":
        return DateTime(now.year, now.month - 1, now.day);
      case "Quarterly":
        return DateTime(now.year, now.month - 3, now.day);
      case "Semi-Annual":
        return DateTime(now.year, now.month - 6, now.day);
      case "Annual":
        return DateTime(now.year - 1, now.month, now.day);
      default:
        return now.subtract(Duration(days: 7)); // Default to weekly
    }
  }

  /// ✅ **Get Total Mood Count for Scaling Bars**
  int getTotalMoodCount() {
    return moodData.values.fold(0, (sum, count) => sum + count);
  }
}
