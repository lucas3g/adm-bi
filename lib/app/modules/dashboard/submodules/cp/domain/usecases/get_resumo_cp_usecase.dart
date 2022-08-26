// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/domain/entities/cp_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/domain/exceptions/cp_exception.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/domain/repositories/cp_repository.dart';

abstract class IGetResumoCPUseCase {
  Future<Either<ICPException, List<CP>>> call();
}

class GetResumoCPUseCase implements IGetResumoCPUseCase {
  final ICPRepository repository;

  GetResumoCPUseCase({
    required this.repository,
  });

  @override
  Future<Either<ICPException, List<CP>>> call() async {
    return await repository.getResumoCP();
  }
}
