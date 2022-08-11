import 'package:app_demonstrativo/app/core_module/core_module.dart';
import 'package:app_demonstrativo/app/modules/auth/auth_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/dashboard_module.dart';
import 'package:app_demonstrativo/app/modules/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Module> imports = [
    CoreModule(),
    SplashModule(),
    AuthModule(),
    DashBoardModule(),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/dash', module: DashBoardModule()),
  ];
}
