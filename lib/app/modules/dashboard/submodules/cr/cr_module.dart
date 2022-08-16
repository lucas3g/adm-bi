import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/domain/repositories/cr_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/domain/usecases/get_resumo_cr_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/external/datasources/cr_datasource.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/infra/datasources/cr_datasource.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/infra/repositories/cr_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/blocs/cr_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/cr_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class CRModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<ICRDataSource>(
      (i) => CRDataSource(
        clientHttp: i(),
        localStorage: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<ICRRepository>(
      (i) => CRRepository(
        dataSource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetResumoCRUseCase>(
      (i) => GetResumoCRUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOCS
    BlocBind.singleton<CRBloc>(
      (i) => CRBloc(
        getResumoCRUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => CRPage(
            crBloc: Modular.get<CRBloc>(),
          )),
    ),
  ];
}
