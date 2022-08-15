import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/grafico_vendas.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/projecao_vendas.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';
import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/exceptions/vendas_exception.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/repositories/vendas_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/adapters/projecao_adapter.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/adapters/vendas_adapter.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/adapters/vendas_grafico_adapter.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/datasources/vendas_datasource.dart';
import 'package:dio/dio.dart';

class VendasRepository implements IVendasRepository {
  final IVendasDataSource dataSourceVendas;
  final IVendasDataSource dataSourceGrafico;

  VendasRepository(
      {required this.dataSourceVendas, required this.dataSourceGrafico});

  @override
  Future<Either<IVendasException, List<Vendas>>> getVendas() async {
    try {
      final result = await dataSourceVendas.getVendas();

      final List<Vendas> vendas = [];

      vendas.addAll(result.map((venda) => VendasAdapter.fromMap(venda)));

      return right(vendas);
    } on IVendasException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(VendasException(message: e.message));
    } catch (e) {
      return left(VendasException(message: e.toString()));
    }
  }

  @override
  Future<Either<IVendasException, List<GraficoVendas>>>
      getVendasGrafico() async {
    try {
      final result = await dataSourceGrafico.getVendasGrafico();

      final List<GraficoVendas> vendas = [];

      vendas.addAll(result.map((venda) => VendasGraficoAdapter.fromMap(venda)));

      return right(vendas);
    } on IVendasException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(VendasException(message: e.message));
    } catch (e) {
      return left(VendasException(message: e.toString()));
    }
  }

  @override
  Future<Either<IVendasException, List<ProjecaoVendas>>> getProjecao() async {
    try {
      final result = await dataSourceGrafico.getProjecao();

      final List<ProjecaoVendas> projecao = [];

      projecao.addAll(result.map((venda) => ProjecaoAdapter.fromMap(venda)));

      return right(projecao);
    } on IVendasException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(VendasException(message: e.message));
    } catch (e) {
      return left(VendasException(message: e.toString()));
    }
  }
}
