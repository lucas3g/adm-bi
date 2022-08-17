import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/entities/info_device_entity.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/exceptions/info_device_exception.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/repositories/info_device_repository_interface.dart';
import 'package:app_demonstrativo/app/modules/auth/infra/adapters/info_device_adapter.dart';
import 'package:app_demonstrativo/app/modules/auth/infra/datasources/info_device_datasource_interface.dart';

class InfoDeviceRepository implements IInfoDeviceRepository {
  final IInfoDeviceDataSource infoDeviceDataSource;

  InfoDeviceRepository({
    required this.infoDeviceDataSource,
  });

  @override
  Future<Either<IInfoDeviceException, InfoDeviceEntity>> getInfo() async {
    try {
      final result = await infoDeviceDataSource.getInfo();
      return right(InfoDeviceAdapter.fromMap(result));
    } on IInfoDeviceException catch (e) {
      return left(e);
    } catch (e) {
      return left(InfoDeviceException(
          message: e.toString(), stackTrace: StackTrace.current));
    }
  }
}
