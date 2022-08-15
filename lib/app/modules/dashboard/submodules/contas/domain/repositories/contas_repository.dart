import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/domain/exceptions/contas_exception.dart';

abstract class IContasRepository {
  Future<Either<IContasException, List<Contas>>> getContas();
}
