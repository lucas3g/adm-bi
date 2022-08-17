// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/events/info_device_events.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/events/verify_license_events.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/states/info_device_states.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/states/verify_license_states.dart';
import 'package:app_demonstrativo/app/utils/my_snackbar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import 'package:app_demonstrativo/app/app_module.dart';
import 'package:app_demonstrativo/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/info_device_bloc.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/verify_license_bloc.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';

class SplashPage extends StatefulWidget {
  final VerifyLicenseBloc verifyLicenseBloc;
  final InfoDeviceBloc infoDeviceBloc;

  const SplashPage({
    Key? key,
    required this.verifyLicenseBloc,
    required this.infoDeviceBloc,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late StreamSubscription sub;
  late StreamSubscription subInfoDevice;
  late String logado = 'N';
  late String id = '';

  Future<void> init() async {
    BotToast.showLoading();
    BotToast.showText(text: 'Validando licença. Aguarde...');

    await Future.delayed(const Duration(seconds: 2));

    await Modular.isModuleReady<AppModule>();

    final localStorage = Modular.get<ILocalStorage>();

    if (localStorage.getData('LICENCA') != null) {
      id = localStorage.getData('LICENCA');
    }

    if (localStorage.getData('logado') != null) {
      logado = localStorage.getData('logado');
    }

    widget.verifyLicenseBloc.add(VerifyLicenseEvent(id: id));
  }

  @override
  void initState() {
    super.initState();

    widget.infoDeviceBloc.add(GetInfoDeviceEvent());

    subInfoDevice = widget.infoDeviceBloc.stream.listen((state) async {
      if (state is InfoDeviceSuccessState) {
        id = state.infoDeviceEntity.id;
      }
    });

    init();

    sub = widget.verifyLicenseBloc.stream.listen((state) {
      if (state is VerifyLicenseActiveState) {
        BotToast.closeAllLoading();
        BotToast.cleanAll();
        if (logado == 'S') {
          Modular.to.navigate('/dash/');
        } else {
          Modular.to.navigate('/auth/');
        }
        return;
      }

      if (state is VerifyLicenseNotActiveState) {
        BotToast.closeAllLoading();
        BotToast.cleanAll();
        MySnackBar(
            message:
                'Licença não esta ativa. Por favor entre em contato com o suporte');
        Modular.to.navigate('/auth/');
        return;
      }

      if (state is VerifyLicenseNotFoundState) {
        BotToast.closeAllLoading();
        BotToast.cleanAll();
        MySnackBar(
            message:
                'Licença não encontrada. Por favor entre em contato com o suporte');
        Modular.to.navigate('/auth/');
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/logo.json',
              width: context.screenWidth * .6,
            ),
            const Divider(),
            Text(
              'Demonstrativo',
              style: AppTheme.textStyles.titleSplash,
            ),
          ],
        ),
      ),
    );
  }
}
