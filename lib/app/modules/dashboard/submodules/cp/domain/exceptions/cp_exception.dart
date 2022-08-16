abstract class ICPException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ICPException({
    required this.message,
    required this.stackTrace,
  });
}

class CPException extends ICPException {
  const CPException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
