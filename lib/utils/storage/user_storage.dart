import 'package:get_storage/get_storage.dart';

class UserStorage {
  final GetStorage _storage = GetStorage();

  // ✅ Save UID locally
  void saveUid(String uid) {
    _storage.write("uid", uid);
  }

  // ✅ Retrieve UID
  String? getUid() {
    return _storage.read("uid");
  }

  // ✅ Clear UID on logout
  void clearUid() {
    _storage.remove("uid");
    clearMoods();
    clearStressLevels();
    deletePlanDetails();
  }

  // ✅ Store stress levels locally
  void saveStressLevels(Map<String, int> newStressLevels) {
    final existing = getStoredStressLevels();
    existing.addAll(newStressLevels);
    _storage.write("storedStressLevels", existing);
  }

  // ✅ Retrieve stored stress levels with type safety
  Map<String, int> getStoredStressLevels() {
    final raw = _storage.read("storedStressLevels") as Map<String, dynamic>? ?? {};
    return raw.map<String, int>(
          (key, value) => MapEntry(key, _convertToInt(value)),
    );
  }

  // ✅ Clear stress levels
  void clearStressLevels() {
    _storage.remove("storedStressLevels");
  }

  // ✅ Store stress data locally
  void saveStressData(Map<String, double> newStressData) {
    final existing = getStoredStressData();
    existing.addAll(newStressData);
    _storage.write("storedStressData", existing);
  }

  // ✅ Retrieve stress data with type conversion
  Map<String, double> getStoredStressData() {
    final raw = _storage.read("storedStressData") as Map<String, dynamic>? ?? {};
    return raw.map<String, double>(
          (key, value) => MapEntry(key, _convertToDouble(value)),
    );
  }

  // ✅ Store moods locally
  void saveMoods(Map<String, String> newMoods) {
    final existing = getStoredMoods();
    existing.addAll(newMoods);
    _storage.write("storedMoods", existing);
  }

  // ✅ Retrieve moods with type safety
  Map<String, String> getStoredMoods() {
    final raw = _storage.read("storedMoods") as Map<String, dynamic>? ?? {};
    return raw.map<String, String>(
          (key, value) => MapEntry(key, value.toString()),
    );
  }

  // ✅ Clear moods
  void clearMoods() {
    _storage.remove("storedMoods");
  }

  // ✅ Save plan details
  void savePlanDetails(Map<String, dynamic> planDetails) {
    _storage.write('selectedPlan', planDetails);
  }

  // ✅ Retrieve plan details
  Map<String, dynamic>? getPlanDetails() {
    return _storage.read('selectedPlan') as Map<String, dynamic>?;
  }

  // ✅ Delete plan details
  void deletePlanDetails() {
    _storage.remove('selectedPlan');
  }

  // 🔥 Type conversion helpers
  double _convertToDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  int _convertToInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}