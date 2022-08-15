abstract class ICCustoException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ICCustoException({
    required this.message,
    required this.stackTrace,
  });
}

class CCustoException extends ICCustoException {
  const CCustoException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
