// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/domain/exceptions/contas_exception.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/domain/repositories/contas_repository.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/infra/adapters/contas_adapter.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/infra/datasources/contas_datasource.dart';
import 'package:dio/dio.dart';

class ContasRepository implements IContasRepository {
  final IContasDataSource dataSource;

  ContasRepository({
    required this.dataSource,
  });

  @override
  Future<Either<IContasException, List<Contas>>> getContas() async {
    try {
      final result = await dataSource.getContas();

      final List<Contas> contas = [];

      contas.addAll(result.map((conta) => ContasAdapter.fromMap(conta)));

      return right(contas);
    } on IContasException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(ContasException(message: e.message));
    } catch (e) {
      return left(ContasException(message: e.toString()));
    }
  }
}
