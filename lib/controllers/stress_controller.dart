import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/storage/user_storage.dart';

class StressController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserStorage _storage = UserStorage();

  var selectedPeriod = "Weekly".obs; // Default period
  var stressData = <String, double>{"Low": 40, "Moderate": 35, "High": 25}.obs; // Stress distribution
  var averageStressLevel = 0.0.obs; // Average stress level of the user

  @override
  void onInit() {
    super.onInit();
    fetchStressData(); // Fetch stress data when initialized
  }

  // ✅ Fetch Stress Data from Firestore
  Future<void> fetchStressData() async {
    String? uid = _storage.getUid();
    if (uid == null) {
      print("❌ Error: UID is null");
      return;
    }

    try {
      var stressRef = _firestore.collection("users").doc(uid).collection("moodTracking");
      var snapshot = await stressRef.get();

      if (snapshot.docs.isEmpty) {
        print("⚠️ No stress data found.");
        return;
      }

      // ✅ Get the start date based on selected period
      DateTime startDate = _getStartDateForPeriod();
      List<int> stressLevels = [];

      for (var doc in snapshot.docs) {
        String dateStr = doc.id; // Firestore doc name is the date
        DateTime docDate = DateFormat('yyyy-MM-dd').parse(dateStr);

        if (docDate.isAfter(startDate) || docDate.isAtSameMomentAs(startDate)) {
          int stress = (doc.data()["stressLevel"] ?? 50).toInt(); // Default 50 if missing
          stressLevels.add(stress);
        }
      }

      if (stressLevels.isEmpty) {
        print("⚠️ No stress data found for the selected period.");
        return;
      }

      calculateStressDistribution(stressLevels);
      calculateAverageStress(stressLevels);
    } catch (e) {
      print("❌ Firestore Fetch Error: $e");
    }
  }

  // ✅ Update Period Selection and Refresh Data
  void updatePeriod(String newPeriod) {
    selectedPeriod.value = newPeriod;
    fetchStressData(); // Refresh stress data
  }

  // ✅ Get Start Date Based on Selected Period
  DateTime _getStartDateForPeriod() {
    DateTime now = DateTime.now();
    switch (selectedPeriod.value) {
      case "Weekly":
        return now.subtract(const Duration(days: 7));
      case "Monthly":
        return DateTime(now.year, now.month - 1, now.day);
      case "Quarterly":
        return DateTime(now.year, now.month - 3, now.day);
      case "Semi-Annual":
        return DateTime(now.year, now.month - 6, now.day);
      case "Annual":
        return DateTime(now.year - 1, now.month, now.day);
      default:
        return now; // Default is "Daily", so return today's date
    }
  }

  // ✅ Calculate Stress Distribution (Low, Moderate, High)
  void calculateStressDistribution(List<int> stressLevels) {
    if (stressLevels.isEmpty) return;

    int lowCount = stressLevels.where((s) => s <= 30).length;
    int moderateCount = stressLevels.where((s) => s > 30 && s <= 60).length;
    int highCount = stressLevels.where((s) => s > 60).length;
    int total = stressLevels.length;

    stressData.value = {
      "Low": (lowCount / total) * 100,
      "Moderate": (moderateCount / total) * 100,
      "High": (highCount / total) * 100,
    };

    print("📊 Updated Stress Data: $stressData");
  }

  // ✅ Calculate Average Stress Level
  void calculateAverageStress(List<int> stressLevels) {
    if (stressLevels.isEmpty) {
      averageStressLevel.value = 0;
      return;
    }

    double avg = stressLevels.reduce((a, b) => a + b) / stressLevels.length;
    averageStressLevel.value = avg;

    print("📊 Updated Average Stress Level: ${averageStressLevel.value}%");
  }
}
