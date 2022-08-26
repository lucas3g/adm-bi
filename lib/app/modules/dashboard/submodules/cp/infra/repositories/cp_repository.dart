// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/domain/entities/cp_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/domain/exceptions/cp_exception.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/domain/repositories/cp_repository.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/infra/adapters/cp_adapter.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/infra/datasources/cp_datasource.dart';
import 'package:dio/dio.dart';

class CPRepository implements ICPRepository {
  final ICPDataSource dataSource;

  CPRepository({
    required this.dataSource,
  });

  @override
  Future<Either<ICPException, List<CP>>> getResumoCP() async {
    try {
      final result = await dataSource.getResumoCP();

      final List<CP> crs = [];

      crs.addAll(result.map((cr) => CPAdapter.fromMap(cr)));

      return right(crs);
    } on ICPException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(CPException(message: e.message));
    } catch (e) {
      return left(CPException(message: e.toString()));
    }
  }
}
