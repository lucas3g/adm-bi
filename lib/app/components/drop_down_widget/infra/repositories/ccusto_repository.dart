import 'package:adm_bi/app/components/drop_down_widget/domain/exception/ccusto_exception.dart';
import 'package:adm_bi/app/components/drop_down_widget/domain/entities/ccusto_entity.dart';
import 'package:adm_bi/app/components/drop_down_widget/domain/repositories/ccusto_repository.dart';
import 'package:adm_bi/app/components/drop_down_widget/infra/adapters/ccusto_adapter.dart';
import 'package:adm_bi/app/components/drop_down_widget/infra/datasources/ccusto_datasource.dart';
import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:dio/dio.dart';

class CCustoRepository implements ICCustoRepository {
  final ICCustoDataSource dataSource;

  CCustoRepository({required this.dataSource});

  @override
  Future<Either<ICCustoException, List<CCusto>>> getCCustos() async {
    try {
      final result = await dataSource.getCCustos();

      final List<CCusto> ccustos = [];

      ccustos.addAll(result.map((ccusto) => CCustoAdapter.fromMap(ccusto)));

      return right(ccustos);
    } on ICCustoException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(CCustoException(message: e.message));
    } catch (e) {
      return left(CCustoException(message: e.toString()));
    }
  }
}
