import 'package:speed_bi/app/core_module/types/either.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/contas/domain/exceptions/contas_exception.dart';

abstract class IContasRepository {
  Future<Either<IContasException, List<Contas>>> getContas();
}
