import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/domain/entities/cp_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/domain/exceptions/cp_exception.dart';

abstract class ICPRepository {
  Future<Either<ICPException, List<CP>>> getResumoCP();
}
