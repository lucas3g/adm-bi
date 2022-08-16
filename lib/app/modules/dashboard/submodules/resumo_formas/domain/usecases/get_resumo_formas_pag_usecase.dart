// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/domain/entities/formas_pag_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/domain/exceptions/formas_pag_exception.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/domain/repositories/formas_pag_repository.dart';

abstract class IGetResumoFormasPagUseCase {
  Future<Either<IFormasPagException, List<FormasPag>>> call();
}

class GetResumoFormasPagUseCase implements IGetResumoFormasPagUseCase {
  final IFormasPagRepository repository;

  GetResumoFormasPagUseCase({
    required this.repository,
  });

  @override
  Future<Either<IFormasPagException, List<FormasPag>>> call() async {
    return await repository.getResumoFormasPag();
  }
}
