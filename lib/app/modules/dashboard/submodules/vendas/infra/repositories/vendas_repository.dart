import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';
import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/exceptions/vendas_exception.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/repositories/vendas_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/adapters/vendas_adapter.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/datasources/vendas_datasource.dart';
import 'package:dio/dio.dart';

class VendasRepository implements IVendasRepository {
  final IVendasDataSource dataSource;

  VendasRepository({required this.dataSource});

  @override
  Future<Either<IVendasException, List<Vendas>>> getVendas() async {
    try {
      final result = await dataSource.getVendas();

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
}
