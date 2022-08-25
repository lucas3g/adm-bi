import 'package:speed_bi/app/core_module/types/either.dart';
import 'package:speed_bi/app/modules/auth/domain/entities/info_device_entity.dart';
import 'package:speed_bi/app/modules/auth/domain/exceptions/info_device_exception.dart';

abstract class IInfoDeviceRepository {
  Future<Either<IInfoDeviceException, InfoDeviceEntity>> getInfo();
}
