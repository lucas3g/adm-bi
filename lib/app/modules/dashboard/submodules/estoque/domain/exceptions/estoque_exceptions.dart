abstract class IEstoqueException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IEstoqueException({
    required this.message,
    required this.stackTrace,
  });
}

class EstoqueException extends IEstoqueException {
  const EstoqueException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
