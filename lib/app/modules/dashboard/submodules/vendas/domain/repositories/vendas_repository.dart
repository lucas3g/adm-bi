import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/grafico_vendas.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/exceptions/vendas_exception.dart';

abstract class IVendasRepository {
  Future<Either<IVendasException, List<Vendas>>> getVendas();
  Future<Either<IVendasException, List<GraficoVendas>>> getVendasGrafico();
}
