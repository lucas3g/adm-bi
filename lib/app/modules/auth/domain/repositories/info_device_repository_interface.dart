import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/entities/info_device_entity.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/exceptions/info_device_exception.dart';

abstract class IInfoDeviceRepository {
  Future<Either<IInfoDeviceException, InfoDeviceEntity>> getInfo();
}
