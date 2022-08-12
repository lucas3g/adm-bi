import 'package:app_demonstrativo/app/modules/dashboard/presenter/dashboard_page.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/contas_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/cp_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/cr_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/estoque_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/resumo_formas_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/vendas_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

Widget animationPage(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  late double begin = 0;

  const end = 1.0;
  const curve = Curves.ease;

  final tween = Tween(begin: begin, end: end);

  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  return FadeTransition(
    opacity: tween.animate(curvedAnimation),
    child: child,
  );
}

class DashBoardModule extends Module {
  @override
  final List<Module> imports = [
    VendasModule(),
    ContasModule(),
    ResumoFormasModule(),
    CRModule(),
    CPModule(),
    EstoqueModule(),
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
          transition: TransitionType.custom,
          customTransition: CustomTransition(transitionBuilder:
              (context, animation, secondaryAnimation, child) {
            return animationPage(context, animation, secondaryAnimation, child);
          }),
          module: VendasModule(),
        ),
        ModuleRoute(
          '/contas',
          transition: TransitionType.custom,
          customTransition: CustomTransition(transitionBuilder:
              (context, animation, secondaryAnimation, child) {
            return animationPage(context, animation, secondaryAnimation, child);
          }),
          module: ContasModule(),
        ),
        ModuleRoute(
          '/resumo_fp',
          transition: TransitionType.custom,
          customTransition: CustomTransition(transitionBuilder:
              (context, animation, secondaryAnimation, child) {
            return animationPage(context, animation, secondaryAnimation, child);
          }),
          module: ResumoFormasModule(),
        ),
        ModuleRoute(
          '/cr',
          transition: TransitionType.custom,
          customTransition: CustomTransition(transitionBuilder:
              (context, animation, secondaryAnimation, child) {
            return animationPage(context, animation, secondaryAnimation, child);
          }),
          module: CRModule(),
        ),
        ModuleRoute(
          '/cp',
          transition: TransitionType.custom,
          customTransition: CustomTransition(transitionBuilder:
              (context, animation, secondaryAnimation, child) {
            return animationPage(context, animation, secondaryAnimation, child);
          }),
          module: CPModule(),
        ),
        ModuleRoute(
          '/estoque',
          transition: TransitionType.custom,
          customTransition: CustomTransition(transitionBuilder:
              (context, animation, secondaryAnimation, child) {
            return animationPage(context, animation, secondaryAnimation, child);
          }),
          module: EstoqueModule(),
        ),
      ],
    ),
  ];
}
