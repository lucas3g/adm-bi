import 'package:adm_bi/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:adm_bi/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:adm_bi/app/modules/auth/domain/repositories/info_device_repository_interface.dart';
import 'package:adm_bi/app/modules/auth/domain/usecases/get_infos_device_usecase.dart';
import 'package:adm_bi/app/modules/auth/domain/usecases/signin_login_usecase.dart';
import 'package:adm_bi/app/modules/auth/domain/usecases/verify_license_usecase.dart';
import 'package:adm_bi/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:adm_bi/app/modules/auth/external/datasources/get_info_device_datasource.dart';
import 'package:adm_bi/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:adm_bi/app/modules/auth/infra/datasources/info_device_datasource_interface.dart';
import 'package:adm_bi/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:adm_bi/app/modules/auth/infra/repositories/info_device_repository.dart';
import 'package:adm_bi/app/modules/auth/presenter/auth_page.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/auth_bloc.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/info_device_bloc.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/verify_license_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class AuthModule extends Module {
  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IAuthDataSource>(
      (i) => AuthDataSource(
        clientHttp: i(),
      ),
    ),
    Bind.factory<IInfoDeviceDataSource>(
      (i) => InfoDeviceDataSource(),
    ),

    //REPOSITORIES
    Bind.factory<IAuthRepository>(
      (i) => AuthRepository(
        dataSource: i(),
      ),
    ),
    Bind.factory<IInfoDeviceRepository>(
      (i) => InfoDeviceRepository(
        infoDeviceDataSource: i(),
      ),
    ),

    //USECASES
    Bind.factory<ISignInLoginUseCase>(
      (i) => SignInLoginUseCase(
        repository: i(),
      ),
    ),
    Bind.factory<IGetInfosDeviceUseCase>(
      (i) => GetInfosDeviceUseCase(
        infoDeviceRepository: i(),
      ),
    ),
    Bind.factory(
      (i) => VerifyLicenseUseCase(
        authRepository: i(),
      ),
    ),

    //BLOCS
    BlocBind.singleton<AuthBloc>(
      (i) => AuthBloc(
        signInLoginUseCase: i(),
      ),
    ),
    BlocBind.singleton(
      (i) => InfoDeviceBloc(
        getInfosDeviceUseCase: i(),
      ),
    ),
    BlocBind.singleton(
      (i) => VerifyLicenseBloc(
        verifyLicenseUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => AuthPage(
            authBloc: Modular.get<AuthBloc>(),
            localStorage: Modular.get<ILocalStorage>(),
            infoDeviceBloc: Modular.get<InfoDeviceBloc>(),
            verifyLicenseBloc: Modular.get<VerifyLicenseBloc>(),
          )),
    ),
  ];
}
