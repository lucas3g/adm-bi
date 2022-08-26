// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/domain/exceptions/contas_exception.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/domain/repositories/contas_repository.dart';

abstract class IGetSaldoContasUseCase {
  Future<Either<IContasException, List<Contas>>> call();
}

class GetSaldoContasUseCase implements IGetSaldoContasUseCase {
  final IContasRepository repository;

  GetSaldoContasUseCase({
    required this.repository,
  });

  @override
  Future<Either<IContasException, List<Contas>>> call() async {
    return await repository.getContas();
  }
}
