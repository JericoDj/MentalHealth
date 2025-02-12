import 'package:get_storage/get_storage.dart';

class UserStorage {
  final GetStorage _storage = GetStorage(); // Singleton instance of GetStorage

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
}
