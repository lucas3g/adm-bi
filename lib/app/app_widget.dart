import 'package:adm_bi/app/theme/app_theme.dart';
import 'package:adm_bi/app/utils/navigation_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setNavigatorKey(NavigationService.navigatorKey);
    Modular.setObservers([
      Asuka.asukaHeroController,
      BotToastNavigatorObserver(),
    ]);

    return MaterialApp.router(
      title: 'ADM BI',
      builder: (context, widget) {
        widget = Asuka.builder(context, widget);
        widget = BotToastInit()(context, widget);
        return widget;
      },
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: AppTheme.colors.primary,
        scaffoldBackgroundColor: AppTheme.colors.backgroundPrimary,
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.colors.primary,
          // iconTheme: const IconThemeData(
          //   color: Colors.white,
          // ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
