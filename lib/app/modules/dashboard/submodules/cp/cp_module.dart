import 'package:speed_bi/app/modules/dashboard/submodules/cp/domain/repositories/cp_repository.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/cp/domain/usecases/get_resumo_cp_usecase.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/cp/external/datasources/cP_datasource.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/cp/infra/datasources/cp_datasource.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/cp/infra/repositories/cp_repository.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/cp/presenter/blocs/cp_bloc.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/cp/presenter/cp_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class CPModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<ICPDataSource>(
      (i) => CPDataSource(
        clientHttp: i(),
        localStorage: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<ICPRepository>(
      (i) => CPRepository(
        dataSource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetResumoCPUseCase>(
      (i) => GetResumoCPUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOCS
    BlocBind.singleton<CPBloc>(
      (i) => CPBloc(
        getResumoCPUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => CPPage(
            cpBloc: Modular.get<CPBloc>(),
          )),
    ),
  ];
}
