// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:speed_bi/app/core_module/types/either.dart';
import 'package:speed_bi/app/modules/auth/domain/entities/user_entity.dart';
import 'package:speed_bi/app/modules/auth/domain/entities/verify_license_entity.dart';
import 'package:speed_bi/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:speed_bi/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:speed_bi/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:speed_bi/app/modules/auth/infra/adapters/verify_license_adapter.dart';
import 'package:speed_bi/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:dio/dio.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository({
    required this.dataSource,
  });

  @override
  Future<Either<IAuthException, bool>> login({required User user}) async {
    try {
      final result = await dataSource.login(map: UserAdapter.toMap(user));

      return right(result);
    } on IAuthException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(AuthException(message: e.message));
    } catch (e) {
      return left(AuthException(message: e.toString()));
    }
  }

  @override
  Future<Either<IAuthException, VerifyLicenseEntity>> verifyLicense(
      String id) async {
    try {
      final response = await dataSource.verifyLicense(id);
      final result = VerifyLicenseAdapter.fromMap(response);
      return right(result);
    } on AuthException catch (e) {
      return left(e);
    } catch (e) {
      return left(
          AuthException(message: e.toString(), stackTrace: StackTrace.current));
    }
  }
}
