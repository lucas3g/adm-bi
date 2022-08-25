import 'package:speed_bi/app/core_module/types/either.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/resumo_formas/domain/entities/formas_pag_entity.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/resumo_formas/domain/exceptions/formas_pag_exception.dart';

abstract class IFormasPagRepository {
  Future<Either<IFormasPagException, List<FormasPag>>> getResumoFormasPag();
}
