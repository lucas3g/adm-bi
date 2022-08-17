import 'adapters/shared_params.dart';

abstract class ILocalStorage {
  Future<bool> setData({required SharedParams params});
  dynamic getData(String key);
  Future<bool> removeData(String key);
}
