import 'package:app_demonstrativo/app/modules/auth/presenter/auth_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      transition: TransitionType.fadeIn,
      duration: const Duration(milliseconds: 600),
      child: ((context, args) => const AuthPage()),
    ),
  ];
}
