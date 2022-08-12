abstract class IVendasException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IVendasException({
    required this.message,
    required this.stackTrace,
  });
}

class VendasException extends IVendasException {
  const VendasException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
