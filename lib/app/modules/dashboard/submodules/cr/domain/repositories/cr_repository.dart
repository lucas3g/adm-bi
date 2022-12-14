import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/domain/entities/cr_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/domain/exceptions/cr_exception.dart';

abstract class ICRRepository {
  Future<Either<ICRException, List<CR>>> getResumoCR();
}
