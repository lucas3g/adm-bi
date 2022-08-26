import 'package:adm_bi/app/modules/auth/domain/entities/info_device_entity.dart';

abstract class InfoDeviceStates {}

class InfoDeviceInitialState extends InfoDeviceStates {}

class InfoDeviceLoadingState extends InfoDeviceStates {}

class InfoDeviceSuccessState extends InfoDeviceStates {
  final InfoDeviceEntity infoDeviceEntity;

  InfoDeviceSuccessState({
    required this.infoDeviceEntity,
  });
}

class InfoDeviceErrorState extends InfoDeviceStates {
  final String message;
  final StackTrace? stackTrace;

  InfoDeviceErrorState({
    required this.message,
    this.stackTrace,
  });
}
