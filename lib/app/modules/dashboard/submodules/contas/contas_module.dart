import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/contas_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContasModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const ContasPage()),
    ),
  ];
}
