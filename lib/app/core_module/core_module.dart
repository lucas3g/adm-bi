import 'package:shared_preferences/shared_preferences.dart';

import 'services/shared_preferences/local_storage_interface.dart';
import 'services/shared_preferences/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'services/client_http/client_http_interface.dart';
import 'services/client_http/dio_client_http.dart';

Bind<Dio> _dioFactory() {
  final baseOptions = BaseOptions(
    // baseUrl: baseUrl,
    headers: {'Content-Type': 'application/json'},
  );
  return Bind.factory<Dio>((i) => Dio(baseOptions), export: true);
}

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    _dioFactory(),
    Bind.factory<IClientHttp>(
      (i) => DioClientHttp(i()),
      export: true,
    ),
    AsyncBind<SharedPreferences>(
      (i) => SharedPreferences.getInstance(),
      export: true,
    ),
    Bind<ILocalStorage>(
      ((i) => SharedPreferencesService(sharedPreferences: i())),
      export: true,
    ),
  ];
}
