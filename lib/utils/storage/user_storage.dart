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
    deletePlanDetails(); // 🔥 Ensure plan details are also cleared
  }

  // ✅ **Store stress levels locally (without duplicates)**
  void saveStressLevels(Map<String, int> newStressLevels) {
    Map<String, int> existingStress = _storage.read("storedStressLevels") ?? {};

    // 🔥 Add only missing stress levels
    newStressLevels.forEach((date, stress) {
      if (!existingStress.containsKey(date)) {
        existingStress[date] = stress;
      }
    });

    _storage.write("storedStressLevels", existingStress);
  }

  // ✅ **Retrieve stored stress levels**
  Map<String, int> getStoredStressLevels() {
    return _storage.read("storedStressLevels") ?? {};
  }

  // ✅ **Clear stored stress levels**
  void clearStressLevels() {
    _storage.remove("storedStressLevels");
  }

  // ✅ **Store stress data locally (without duplicates)**
  void saveStressData(Map<String, double> newStressData) {
    Map<String, double> existingStressData = _storage.read("storedStressData") ?? {};

    // 🔥 Add only missing stress data
    newStressData.forEach((date, stress) {
      if (!existingStressData.containsKey(date)) {
        existingStressData[date] = stress;
      }
    });

    _storage.write("storedStressData", existingStressData);
  }

  // ✅ **Retrieve stored stress data**
  Map<String, double> getStoredStressData() {
    return _storage.read("storedStressData") ?? {};
  }

  // ✅ **Store moods locally**
  void saveMoods(Map<String, String> newMoods) {
    Map<String, String> existingMoods = _storage.read("storedMoods") ?? {};

    newMoods.forEach((date, mood) {
      if (!existingMoods.containsKey(date)) {
        existingMoods[date] = mood;
      }
    });

    _storage.write("storedMoods", existingMoods);
  }

  // ✅ **Retrieve stored moods**
  Map<String, String> getStoredMoods() {
    return _storage.read("storedMoods") ?? {};
  }

  // ✅ **Clear stored moods**
  void clearMoods() {
    _storage.remove("storedMoods");
  }

  // ✅ **Save selected plan details**
  void savePlanDetails(Map<String, dynamic> planDetails) {
    _storage.write('selectedPlan', planDetails);
  }

  // ✅ **Retrieve saved plan details**
  Map<String, dynamic>? getPlanDetails() {
    return _storage.read('selectedPlan');
  }

  // ✅ **Delete selected plan details**
  void deletePlanDetails() {
    _storage.remove('selectedPlan');
  }
}