// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/domain/entities/cr_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/domain/exceptions/cr_exception.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/domain/repositories/cr_repository.dart';

abstract class IGetResumoCRUseCase {
  Future<Either<ICRException, List<CR>>> call();
}

class GetResumoCRUseCase implements IGetResumoCRUseCase {
  final ICRRepository repository;

  GetResumoCRUseCase({
    required this.repository,
  });

  @override
  Future<Either<ICRException, List<CR>>> call() async {
    return await repository.getResumoCR();
  }
}
