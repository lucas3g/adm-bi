import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/repositories/vendas_repository.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/usecases/get_projecao_usecase.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_grafico_usecase.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_usecase.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/external/datasources/vendas_datasource.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/infra/datasources/vendas_datasource.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/infra/repositories/vendas_repository.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/grafico_bloc.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/projecao_bloc.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/vendas_bloc.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/presenter/vendas_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

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
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IVendasRepository>(
      (i) => VendasRepository(
        dataSourceVendas: i(),
        dataSourceGrafico: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetProjecaoUseCase>(
      (i) => GetProjecaoUseCase(
        repository: i(),
      ),
      export: true,
    ),
    Bind.factory<IGetVendasGraficoUseCase>(
      (i) => GetVendasGraficoUseCase(
        repository: i(),
      ),
      export: true,
    ),
    Bind.factory<IGetVendasUseCase>(
      (i) => GetVendasUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOC
    BlocBind.singleton<ProjecaoBloc>(
      (i) => ProjecaoBloc(
        getProjecaoUseCase: i(),
      ),
      export: true,
    ),
    BlocBind.singleton<GraficoBloc>(
      (i) => GraficoBloc(
        getVendasGraficoUseCase: i(),
      ),
      export: true,
    ),
    BlocBind.singleton<VendasBloc>(
      (i) => VendasBloc(
        getVendasUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => VendasPage(
            projecaoBloc: Modular.get<ProjecaoBloc>(),
            graficoBloc: Modular.get<GraficoBloc>(),
            vendasBloc: Modular.get<VendasBloc>(),
          )),
    ),
  ];
}
