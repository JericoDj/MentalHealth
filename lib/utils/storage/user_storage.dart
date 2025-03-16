import 'package:get_storage/get_storage.dart';

class UserStorage {
  final GetStorage _storage = GetStorage();

  // Save UID locally
  void saveUid(String uid) {
    _storage.write("uid", uid);
  }

  // Retrieve UID
  String? getUid() {
    return _storage.read("uid");
  }

  // Clear UID on logout
  void clearUid() {
    _storage.remove("uid");
  }

  // ✅ Save selected plan details
  void savePlanDetails(Map<String, dynamic> planDetails) {
    _storage.write('selectedPlan', planDetails);
  }

  // ✅ Retrieve saved plan details
  Map<String, dynamic>? getPlanDetails() {
    return _storage.read('selectedPlan');
  }

  // ✅ Delete selected plan details
  void deletePlanDetails() {
    _storage.remove('selectedPlan');
  }
}
