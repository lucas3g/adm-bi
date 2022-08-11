import 'local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

import 'adapters/shared_params.dart';

class SharedPreferencesService implements ILocalStorage {
  final SharedPreferences sharedPreferences;

  static const String _prefix = 'flutter.';

  SharedPreferencesService({
    required this.sharedPreferences,
  });

  @override
  dynamic getData(String key) {
    final result = sharedPreferences.get(key);

    if (result != null) {
      return result;
    }

    return null;
  }

  @override
  Future<bool> setData({required SharedParams params}) async {
    switch (params.value.runtimeType) {
      case String:
        return await sharedPreferences.setString(params.key, params.value);
      case int:
        return await sharedPreferences.setInt(params.key, params.value);
      case bool:
        return await sharedPreferences.setBool(params.key, params.value);
      case double:
        return await sharedPreferences.setDouble(params.key, params.value);
      case List<String>:
        return await sharedPreferences.setStringList(params.key, params.value);
    }
    return false;
  }

  @override
  Future<bool> removeData(String key) async {
    return await sharedPreferences.remove(key);
  }

  @override
  void setMockInitialValues(Map<String, Object> values) {
    final Map<String, Object> newValues =
        values.map<String, Object>((String key, Object value) {
      String newKey = key;
      if (!key.startsWith(_prefix)) {
        newKey = '$_prefix$key';
      }
      return MapEntry<String, Object>(newKey, value);
    });
    SharedPreferencesStorePlatform.instance =
        InMemorySharedPreferencesStore.withData(newValues);
  }
}

class SharedPreferencesException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  SharedPreferencesException(
    this.message, {
    this.stackTrace,
  });
}
