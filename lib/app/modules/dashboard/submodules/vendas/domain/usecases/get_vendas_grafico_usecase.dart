import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/grafico_vendas.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/exceptions/vendas_exception.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/repositories/vendas_repository.dart';

abstract class IGetVendasGraficoUseCase {
  Future<Either<IVendasException, List<GraficoVendas>>> call();
}

class GetVendasGraficoUseCase implements IGetVendasGraficoUseCase {
  final IVendasRepository repository;

  GetVendasGraficoUseCase({required this.repository});

  @override
  Future<Either<IVendasException, List<GraficoVendas>>> call() async {
    return await repository.getVendasGrafico();
  }
}
