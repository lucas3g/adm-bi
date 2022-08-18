// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/entities/estoque_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/exceptions/estoque_exceptions.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/repositories/estoque_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/infra/adapters/estoque_adapter.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/infra/datasources/estoque_datasource.dart';
import 'package:dio/dio.dart';

class EstoqueRepository implements IEstoqueRepository {
  final IEstoqueDataSource dataSource;

  EstoqueRepository({
    required this.dataSource,
  });

  @override
  Future<Either<IEstoqueException, List<Estoque>>> getEstoqueMinimo() async {
    try {
      final result = await dataSource.getEstoqueMinimo();

      final List<Estoque> estoques = [];

      estoques.addAll(result.map((estoque) => EstoqueAdapter.fromMap(estoque)));

      return right(estoques);
    } on IEstoqueException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(EstoqueException(message: e.message));
    } catch (e) {
      return left(EstoqueException(message: e.toString()));
    }
  }
}
