import 'package:app_demonstrativo/app/components/drop_down_widget/domain/repositories/ccusto_repository.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/domain/usecases/get_ccustos_usecase.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/external/datasources/ccusto_datasource.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/infra/datasources/ccusto_datasource.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/infra/repositories/ccusto_repository.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/presenter/dashboard_page.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/contas_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/cp_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/cr_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/estoque_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/resumo_formas_module.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/vendas_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

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
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<ICCustoDataSource>(
      (i) => CCustoDataSource(
        clientHttp: i(),
        localStorage: i(),
      ),
    ),

    //REPOSITORIES
    Bind.factory<ICCustoRepository>(
      (i) => CCustoRepository(
        dataSource: i(),
      ),
    ),

    //USECASES
    Bind.factory<IGetCCustoUseCase>(
      (i) => GetCCustoUseCase(
        repository: i(),
      ),
    ),

    //BLOC
    BlocBind.singleton(
      (i) => CCustoBloc(
        getCCustoUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => DashBoardPage(
            ccustoBloc: Modular.get<CCustoBloc>(),
          )),
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
