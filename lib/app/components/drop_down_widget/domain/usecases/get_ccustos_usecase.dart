import 'package:app_demonstrativo/app/components/drop_down_widget/domain/entities/ccusto_entity.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/domain/exception/ccusto_exception.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/domain/repositories/ccusto_repository.dart';
import 'package:app_demonstrativo/app/core_module/types/either.dart';

abstract class IGetCCustoUseCase {
  Future<Either<ICCustoException, List<CCusto>>> call();
}

class GetCCustoUseCase implements IGetCCustoUseCase {
  final ICCustoRepository repository;

  GetCCustoUseCase({required this.repository});

  @override
  Future<Either<ICCustoException, List<CCusto>>> call() async {
    return await repository.getCCustos();
  }
}
