import 'package:shared_preferences/shared_preferences.dart';

import 'adapters/shared_params.dart';
import 'local_storage_interface.dart';

class SharedPreferencesService implements ILocalStorage {
  final SharedPreferences sharedPreferences;

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
}

class SharedPreferencesException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  SharedPreferencesException(
    this.message, {
    this.stackTrace,
  });
}
