import 'package:adm_bi/app/core_module/types/either.dart';
import 'package:adm_bi/app/modules/auth/domain/entities/verify_license_entity.dart';
import 'package:adm_bi/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:adm_bi/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class IVerifyLicenseUseCase {
  Future<Either<IAuthException, VerifyLicenseEntity>> call(String id);
}

class VerifyLicenseUseCase implements IVerifyLicenseUseCase {
  final IAuthRepository authRepository;

  VerifyLicenseUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<IAuthException, VerifyLicenseEntity>> call(String id) async {
    return await authRepository.verifyLicense(id);
  }
}
