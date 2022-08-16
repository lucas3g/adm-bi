import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/domain/repositories/formas_pag_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/domain/usecases/get_resumo_formas_pag_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/external/datasources/formas_pag_datasource.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/infra/datasources/formas_pag_datasource.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/infra/repositories/formas_pag_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/formas_pag_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/resumo_formas_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ResumoFormasModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IFormasPagDataSource>(
      (i) => FormasPagDatSource(
        clientHttp: i(),
        localStorage: i(),
      ),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IFormasPagRepository>(
      (i) => FormasPagRepository(
        dataSource: i(),
      ),
      export: true,
    ),

    //USECASES
    Bind.factory<IGetResumoFormasPagUseCase>(
      (i) => GetResumoFormasPagUseCase(
        repository: i(),
      ),
      export: true,
    ),

    //BLOCS
    BlocBind.singleton<FormasPagBloc>(
      (i) => FormasPagBloc(
        getResumoFormasPagUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => ResumoFormasPage(
            formasPagBloc: Modular.get<FormasPagBloc>(),
          )),
    ),
  ];
}
