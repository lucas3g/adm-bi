import 'package:app_demonstrativo/app/modules/auth/domain/entities/info_device_entity.dart';

class InfoDeviceAdapter {
  static InfoDeviceEntity fromMap(Map map) {
    return InfoDeviceEntity(id: map['id']);
  }
}
