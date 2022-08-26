// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/domain/entities/cr_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/domain/exceptions/cr_exception.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/domain/repositories/cr_repository.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/infra/adapters/cr_adapter.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/infra/datasources/cr_datasource.dart';
import 'package:dio/dio.dart';

class CRRepository implements ICRRepository {
  final ICRDataSource dataSource;

  CRRepository({
    required this.dataSource,
  });

  @override
  Future<Either<ICRException, List<CR>>> getResumoCR() async {
    try {
      final result = await dataSource.getResumoCR();

      final List<CR> crs = [];

      crs.addAll(result.map((cr) => CRAdapter.fromMap(cr)));

      return right(crs);
    } on ICRException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(CRException(message: e.message));
    } catch (e) {
      return left(CRException(message: e.toString()));
    }
  }
}
