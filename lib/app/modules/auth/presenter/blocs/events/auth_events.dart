// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_demonstrativo/app/modules/auth/domain/entities/user_entity.dart';

abstract class AuthEvents {}

class AuthSignInEvent extends AuthEvents {
  final User user;

  AuthSignInEvent({
    required this.user,
  });
}
