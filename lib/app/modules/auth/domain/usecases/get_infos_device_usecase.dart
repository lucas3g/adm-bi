import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/entities/info_device_entity.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/exceptions/info_device_exception.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/repositories/info_device_repository_interface.dart';

abstract class IGetInfosDeviceUseCase {
  Future<Either<IInfoDeviceException, InfoDeviceEntity>> call();
}

class GetInfosDeviceUseCase extends IGetInfosDeviceUseCase {
  final IInfoDeviceRepository infoDeviceRepository;

  GetInfosDeviceUseCase({
    required this.infoDeviceRepository,
  });

  @override
  Future<Either<IInfoDeviceException, InfoDeviceEntity>> call() {
    return infoDeviceRepository.getInfo();
  }
}
