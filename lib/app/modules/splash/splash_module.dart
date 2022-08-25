import 'package:speed_bi/app/modules/auth/domain/usecases/get_infos_device_usecase.dart';
import 'package:speed_bi/app/modules/auth/domain/usecases/verify_license_usecase.dart';
import 'package:speed_bi/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:speed_bi/app/modules/auth/external/datasources/get_info_device_datasource.dart';
import 'package:speed_bi/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:speed_bi/app/modules/auth/infra/repositories/info_device_repository.dart';
import 'package:speed_bi/app/modules/auth/presenter/blocs/info_device_bloc.dart';
import 'package:speed_bi/app/modules/auth/presenter/blocs/verify_license_bloc.dart';
import 'package:speed_bi/app/modules/splash/presenter/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class SplashModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCE
    Bind.factory((i) => AuthDataSource(clientHttp: i())),
    Bind.factory((i) => InfoDeviceDataSource()),

    //REPOSITORY
    Bind.factory((i) => AuthRepository(dataSource: i())),
    Bind.factory((i) => InfoDeviceRepository(infoDeviceDataSource: i())),

    //USECASE
    Bind.factory((i) => VerifyLicenseUseCase(authRepository: i())),
    Bind.factory((i) => GetInfosDeviceUseCase(infoDeviceRepository: i())),

    //BLOC
    BlocBind.singleton((i) => VerifyLicenseBloc(verifyLicenseUseCase: i())),
    BlocBind.singleton((i) => InfoDeviceBloc(getInfosDeviceUseCase: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => SplashPage(
            verifyLicenseBloc: Modular.get<VerifyLicenseBloc>(),
            infoDeviceBloc: Modular.get<InfoDeviceBloc>(),
          )),
    ),
  ];
}
