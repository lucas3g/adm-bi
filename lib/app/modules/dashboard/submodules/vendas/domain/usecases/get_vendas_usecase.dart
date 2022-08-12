import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/exceptions/vendas_exception.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/repositories/vendas_repository.dart';

abstract class IGetVendasUseCase {
  Future<Either<IVendasException, List<Vendas>>> call();
}

class GetVendasUseCase implements IGetVendasUseCase {
  final IVendasRepository repository;

  GetVendasUseCase({required this.repository});

  @override
  Future<Either<IVendasException, List<Vendas>>> call() async {
    return await repository.getVendas();
  }
}
