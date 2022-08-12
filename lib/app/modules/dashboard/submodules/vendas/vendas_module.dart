import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/repositories/vendas_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_grafico_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/external/datasources/vendas_datasource.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/datasources/vendas_datasource.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/repositories/vendas_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/vendas_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/vendas_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class VendasModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCE
    Bind.factory<IVendasDataSource>(
      (i) => VendasDataSource(
        clientHttp: i(),
        localStorage: i(),
      ),
    ),

    //REPOSITORIES
    Bind.factory<IVendasRepository>(
      (i) => VendasRepository(
        dataSourceVendas: i(),
        dataSourceGrafico: i(),
      ),
    ),

    //USECASES
    Bind.factory<IGetVendasGraficoUseCase>(
      (i) => GetVendasGraficoUseCase(
        repository: i(),
      ),
    ),

    Bind.factory<IGetVendasUseCase>(
      (i) => GetVendasUseCase(
        repository: i(),
      ),
    ),

    //BLOC
    Bind.singleton<VendasBloc>(
      (i) => VendasBloc(
        getVendasUseCase: i(),
        getVendasGraficoUseCase: i(),
      ),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => VendasPage(
            vendasBloc: Modular.get<VendasBloc>(),
          )),
    ),
  ];
}
