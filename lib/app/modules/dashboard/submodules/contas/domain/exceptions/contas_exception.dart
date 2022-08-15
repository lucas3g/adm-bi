abstract class IContasException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IContasException({
    required this.message,
    required this.stackTrace,
  });
}

class ContasException extends IContasException {
  const ContasException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
