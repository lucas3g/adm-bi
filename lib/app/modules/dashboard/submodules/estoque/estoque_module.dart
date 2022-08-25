import 'package:speed_bi/app/modules/dashboard/submodules/estoque/domain/repositories/estoque_repository.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/domain/usecases/get_estoque_minimo_usecase.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/external/datasources/estoque_datasource.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/infra/datasources/estoque_datasource.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/infra/repositories/estoque_repository.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/presenter/blocs/estoque_bloc.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/presenter/estoque_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class EstoqueModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IEstoqueDataSource>(
      (i) => EstoqueDataSource(
        clientHttp: i(),
        localStorage: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IEstoqueRepository>(
      (i) => EstoqueRepository(
        dataSource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetEstoqueMinimoUseCase>(
      (i) => GetEstoqueMinimoUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOCS
    BlocBind.singleton<EstoqueBloc>(
      (i) => EstoqueBloc(
        getEstoqueMinimoUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => EstoquePage(
            estoqueBloc: Modular.get<EstoqueBloc>(),
          )),
    ),
  ];
}
