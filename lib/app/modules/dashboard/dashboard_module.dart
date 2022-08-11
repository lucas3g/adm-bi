import 'package:app_demonstrativo/app/modules/dashboard/presenter/dashboard_page.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/contas_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/vendas_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashBoardModule extends Module {
  @override
  final List<Module> imports = [
    VendasModule(),
    ContasModule(),
  ];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const DashBoardPage()),
      children: [
        ModuleRoute(
          '/vendas',
          transition: TransitionType.rightToLeft,
          module: VendasModule(),
        ),
        ModuleRoute(
          '/contas',
          transition: TransitionType.leftToRight,
          module: ContasModule(),
        ),
      ],
    ),
  ];
}
