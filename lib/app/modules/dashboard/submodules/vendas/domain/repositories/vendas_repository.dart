import 'package:speed_bi/app/core_module/types/either.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/entities/grafico_vendas.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/entities/projecao_vendas.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/exceptions/vendas_exception.dart';

abstract class IVendasRepository {
  Future<Either<IVendasException, List<ProjecaoVendas>>> getProjecao();
  Future<Either<IVendasException, List<GraficoVendas>>> getVendasGrafico();
  Future<Either<IVendasException, List<Vendas>>> getVendas();
}
