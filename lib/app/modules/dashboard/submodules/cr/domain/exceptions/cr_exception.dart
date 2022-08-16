abstract class ICRException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ICRException({
    required this.message,
    required this.stackTrace,
  });
}

class CRException extends ICRException {
  const CRException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
