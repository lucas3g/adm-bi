abstract class IInfoDeviceException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IInfoDeviceException({
    required this.message,
    required this.stackTrace,
  });
}

class InfoDeviceException extends IInfoDeviceException {
  const InfoDeviceException({
    required String message,
    required StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
