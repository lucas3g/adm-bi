import 'package:speed_bi/app/core_module/types/either.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/domain/entities/estoque_entity.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/domain/exceptions/estoque_exceptions.dart';

abstract class IEstoqueRepository {
  Future<Either<IEstoqueException, List<Estoque>>> getEstoqueMinimo();
}
