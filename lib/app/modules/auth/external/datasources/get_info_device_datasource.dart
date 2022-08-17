import 'package:platform_device_id/platform_device_id.dart';

import '../../infra/datasources/info_device_datasource_interface.dart';

class InfoDeviceDataSource implements IInfoDeviceDataSource {
  @override
  Future<dynamic> getInfo() async {
    final deviceId = await PlatformDeviceId.getDeviceId;
    final map = {'id': deviceId};

    return map;
  }
}
