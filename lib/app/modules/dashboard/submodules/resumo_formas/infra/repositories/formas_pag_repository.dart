// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:speed_bi/app/core_module/types/either.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/resumo_formas/domain/entities/formas_pag_entity.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/resumo_formas/domain/exceptions/formas_pag_exception.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/resumo_formas/domain/repositories/formas_pag_repository.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/resumo_formas/infra/adapters/formas_pag_adapter.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/resumo_formas/infra/datasources/formas_pag_datasource.dart';
import 'package:dio/dio.dart';

class FormasPagRepository implements IFormasPagRepository {
  final IFormasPagDataSource dataSource;

  FormasPagRepository({
    required this.dataSource,
  });

  @override
  Future<Either<IFormasPagException, List<FormasPag>>>
      getResumoFormasPag() async {
    try {
      final result = await dataSource.getResumoFormasPag();

      final List<FormasPag> formasPag = [];

      formasPag
          .addAll(result.map((formaPag) => FormasPagAdapter.fromMap(formaPag)));

      return right(formasPag);
    } on IFormasPagException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(FormasPagException(message: e.message));
    } catch (e) {
      return left(FormasPagException(message: e.toString()));
    }
  }
}
