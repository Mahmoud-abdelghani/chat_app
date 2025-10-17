import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? shared;
  static Future<void> init() async {
    shared = await SharedPreferences.getInstance();
  }

  static Future<void> saveData({
    required String key,
    required bool value,
  }) async {
    await shared!.setBool(key, value);
  }

  static bool? getData(String key) {
    return shared!.getBool(key);
  }

  static Future<void> deleteData(String key) async {
    await shared!.remove(key);
  }
}
