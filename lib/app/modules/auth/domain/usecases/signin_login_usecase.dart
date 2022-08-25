// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:speed_bi/app/core_module/types/either.dart';
import 'package:speed_bi/app/modules/auth/domain/entities/user_entity.dart';
import 'package:speed_bi/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:speed_bi/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class ISignInLoginUseCase {
  Future<Either<IAuthException, bool>> call({required User user});
}

class SignInLoginUseCase implements ISignInLoginUseCase {
  final IAuthRepository repository;

  SignInLoginUseCase({
    required this.repository,
  });

  @override
  Future<Either<IAuthException, bool>> call({required User user}) async {
    return await repository.login(user: user);
  }
}
