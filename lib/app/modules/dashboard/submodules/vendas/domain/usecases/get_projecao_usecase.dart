import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/projecao_vendas.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/exceptions/vendas_exception.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/repositories/vendas_repository.dart';

abstract class IGetProjecaoUseCase {
  Future<Either<IVendasException, List<ProjecaoVendas>>> call();
}

class GetProjecaoUseCase implements IGetProjecaoUseCase {
  final IVendasRepository repository;

  GetProjecaoUseCase({required this.repository});

  @override
  Future<Either<IVendasException, List<ProjecaoVendas>>> call() async {
    return await repository.getProjecao();
  }
}
