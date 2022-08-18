// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/entities/estoque_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/exceptions/estoque_exceptions.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/repositories/estoque_repository.dart';

abstract class IGetEstoqueMinimoUseCase {
  Future<Either<IEstoqueException, List<Estoque>>> call();
}

class GetEstoqueMinimoUseCase implements IGetEstoqueMinimoUseCase {
  final IEstoqueRepository repository;

  GetEstoqueMinimoUseCase({
    required this.repository,
  });

  @override
  Future<Either<IEstoqueException, List<Estoque>>> call() async {
    return await repository.getEstoqueMinimo();
  }
}
