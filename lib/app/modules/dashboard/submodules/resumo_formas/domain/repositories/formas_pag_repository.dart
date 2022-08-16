import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/domain/entities/formas_pag_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/domain/exceptions/formas_pag_exception.dart';

abstract class IFormasPagRepository {
  Future<Either<IFormasPagException, List<FormasPag>>> getResumoFormasPag();
}
