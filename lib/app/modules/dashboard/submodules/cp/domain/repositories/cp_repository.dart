import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/domain/entities/cp_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/domain/exceptions/cp_exception.dart';

abstract class ICPRepository {
  Future<Either<ICPException, List<CP>>> getResumoCP();
}
