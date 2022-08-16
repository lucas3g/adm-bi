abstract class IFormasPagException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IFormasPagException({
    required this.message,
    required this.stackTrace,
  });
}

class FormasPagException extends IFormasPagException {
  const FormasPagException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
