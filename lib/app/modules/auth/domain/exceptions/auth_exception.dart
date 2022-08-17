abstract class IAuthException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IAuthException({
    required this.message,
    required this.stackTrace,
  });
}

class AuthException extends IAuthException {
  const AuthException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
