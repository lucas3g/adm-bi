import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/entities/estoque_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/exceptions/estoque_exceptions.dart';

abstract class IEstoqueRepository {
  Future<Either<IEstoqueException, List<Estoque>>> getEstoqueMinimo();
}
