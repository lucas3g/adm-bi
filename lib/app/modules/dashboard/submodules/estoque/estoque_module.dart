import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/presenter/estoque_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstoqueModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const EstoquePage()),
    ),
  ];
}
