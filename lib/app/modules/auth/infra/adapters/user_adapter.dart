import 'package:app_demonstrativo/app/modules/auth/domain/entities/user_entity.dart';

class UserAdapter {
  static Map<String, dynamic> toMap(User user) {
    return {
      'CNPJ': user.cnpj,
      'LOGIN': user.login,
      'SENHA': user.password,
    };
  }
}
