import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/entities/user_entity.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/entities/verify_license_entity.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/exceptions/auth_exception.dart';

abstract class IAuthRepository {
  Future<Either<IAuthException, bool>> login({required User user});
  Future<Either<IAuthException, VerifyLicenseEntity>> verifyLicense(String id);
}
