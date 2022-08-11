import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/cr_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CRModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const CRPage()),
    ),
  ];
}
