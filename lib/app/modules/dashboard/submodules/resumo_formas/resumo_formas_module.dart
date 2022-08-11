import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/resumo_formas_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ResumoFormasModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const ResumoFormasPage()),
    ),
  ];
}
