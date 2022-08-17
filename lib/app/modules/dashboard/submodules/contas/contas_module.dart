import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/domain/repositories/contas_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/domain/usecases/get_contas_saldo_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/external/datasources/contas_datasource.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/infra/repositories/contas_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/contas_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/contas_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ContasModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory(
      (i) => ContasDataSource(
        clientHttp: i(),
        localStorage: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IContasRepository>(
      (i) => ContasRepository(
        dataSource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetSaldoContasUseCase>(
      (i) => GetSaldoContasUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOC
    BlocBind.singleton<ContasBloc>(
      (i) => ContasBloc(
        getSaldoContasUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => ContasPage(
            contasBloc: Modular.get<ContasBloc>(),
          )),
    ),
  ];
}
