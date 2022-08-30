// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:async';

import 'package:adm_bi/app/modules/auth/domain/entities/info_device_entity.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/events/info_device_events.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/events/verify_license_events.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/states/info_device_states.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/states/verify_license_states.dart';
import 'package:asuka/asuka.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:adm_bi/app/components/my_input_widget.dart';
import 'package:adm_bi/app/core_module/services/shared_preferences/adapters/shared_params.dart';
import 'package:adm_bi/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:adm_bi/app/modules/auth/domain/entities/user_entity.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/auth_bloc.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/events/auth_events.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/info_device_bloc.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/states/auth_states.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/verify_license_bloc.dart';
import 'package:adm_bi/app/theme/app_theme.dart';
import 'package:adm_bi/app/utils/constants.dart';
import 'package:adm_bi/app/utils/formatters.dart';
import 'package:adm_bi/app/utils/my_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_whatsapp/share_whatsapp.dart';

class AuthPage extends StatefulWidget {
  final AuthBloc authBloc;
  final ILocalStorage localStorage;
  final InfoDeviceBloc infoDeviceBloc;
  final VerifyLicenseBloc verifyLicenseBloc;

  const AuthPage({
    Key? key,
    required this.authBloc,
    required this.localStorage,
    required this.infoDeviceBloc,
    required this.verifyLicenseBloc,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final fCnpj = FocusNode();
  final fUser = FocusNode();
  final fPassword = FocusNode();

  final cnpjController = TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  final gkCnpj = GlobalKey<FormState>();
  final gkUser = GlobalKey<FormState>();
  final gkPassword = GlobalKey<FormState>();

  final scrollController = ScrollController();

  late bool visiblePassword = true;

  late StreamSubscription sub;
  late StreamSubscription subInfoDevice;
  late StreamSubscription subVerifyLicense;

  late InfoDeviceEntity _infoDeviceEntity;

  Future saveLocalStorage() async {
    await widget.localStorage.setData(
      params: SharedParams(
        key: 'logado',
        value: 'S',
      ),
    );

    await widget.localStorage.setData(
      params: SharedParams(
        key: 'CNPJ',
        value: cnpjController.text.replaceAll('.', '').substring(0, 8),
      ),
    );

    await widget.localStorage.setData(
      params: SharedParams(
        key: 'LICENCA',
        value: _infoDeviceEntity.id,
      ),
    );

    Modular.to.navigate('/dash/');
  }

  Future<void> mostraDialogCodigo(InfoDeviceEntity infoDeviceEntity) async {
    await Asuka.showDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        builder: (_) {
          return AlertDialog(
            elevation: 8,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Código de Autenticação: ${_infoDeviceEntity.id}',
                  style: AppTheme.textStyles.textoTermo.copyWith(fontSize: 16),
                ),
                Text(
                  'Se você já tem uma licença. Por favor, ignore essa mensagem.',
                  style: AppTheme.textStyles.textoTermo.copyWith(fontSize: 13),
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await openWhatsapp(
                            context: context,
                            text:
                                'Código para Licença App DashBoard: ${_infoDeviceEntity.id}',
                            number: '+5554999712433',
                          );
                        },
                        icon: const Icon(Icons.whatsapp_rounded),
                        label: const Text('Enviar código'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> openWhatsapp({
    required BuildContext context,
    required String text,
    required String number,
  }) async {
    final wpp = await shareWhatsapp.installed(type: WhatsApp.standard);

    final business = await shareWhatsapp.installed(type: WhatsApp.business);

    if (wpp || business) {
      await shareWhatsapp.shareText(
        text,
        phone: number,
        type: wpp ? WhatsApp.standard : WhatsApp.business,
      );
    } else {
      MySnackBar(message: "Whatsapp não está instalado");
    }
  }

  @override
  void initState() {
    super.initState();

    widget.infoDeviceBloc.add(GetInfoDeviceEvent());

    subInfoDevice = widget.infoDeviceBloc.stream.listen((state) async {
      if (state is InfoDeviceSuccessState) {
        _infoDeviceEntity = state.infoDeviceEntity;
        mostraDialogCodigo(_infoDeviceEntity);
      }
    });

    subVerifyLicense = widget.verifyLicenseBloc.stream.listen((state) {
      if (state is VerifyLicenseActiveState) {
        final User user = User(
          cnpj: cnpjController.text.trim(),
          login: userController.text.trim(),
          password: passwordController.text.trim(),
        );
        widget.authBloc.add(
          AuthSignInEvent(user: user),
        );
      }
      if (state is VerifyLicenseNotFoundState) {
        MySnackBar(
            message:
                'Licença não encontrada. Por favor, entre em contato com o suporte.');
      }

      if (state is VerifyLicenseNotActiveState) {
        MySnackBar(
            message:
                'Licença não ativa. Por favor, entre em contato com o suporte.');
      }
    });

    sub = widget.authBloc.stream.listen((state) async {
      if (state is AuthErrorState) {
        MySnackBar(message: state.message);
      }

      if (state is AuthSuccessState) {
        await Future.delayed(const Duration(milliseconds: 600));
        await saveLocalStorage();
      }
    });

    fCnpj.addListener(() {
      if (fCnpj.hasFocus) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        );
      }
    });

    fUser.addListener(() {
      if (fUser.hasFocus) {
        scrollController.animateTo(
          50,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        );
      }
    });

    fPassword.addListener(() {
      if (fPassword.hasFocus) {
        scrollController.animateTo(
          100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    fCnpj.removeListener(() {});
    fUser.removeListener(() {});
    fPassword.removeListener(() {});

    super.dispose();
  }

  void mostraDialogDemonstracao() {
    Asuka.showDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        builder: (_) {
          return AlertDialog(
            elevation: 8,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Atenção',
                  style: AppTheme.textStyles.titleDialog,
                ),
                const Divider(),
                Text(
                  'Você irá iniciar uma versão de demonstração os dados são meramente fictícios.',
                  style: AppTheme.textStyles.textDialog,
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                        },
                        icon: const Icon(
                          Icons.cancel_rounded,
                        ),
                        label: const Text('Não'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');

                          await widget.localStorage.setData(
                            params:
                                SharedParams(key: 'CNPJ', value: '97305890'),
                          );

                          Modular.to.navigate('/dash/');
                        },
                        icon: const Icon(Icons.done_rounded),
                        label: const Text('Iniciar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          right: 20,
          left: 20,
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: context.screenHeight * .94,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                SvgPicture.asset(
                  'assets/images/admbi.svg',
                  width: context.screenWidth * .90,
                ),
                Column(
                  children: [
                    Text(
                      'Entre com sua conta',
                      style: AppTheme.textStyles.textoSairApp,
                    ),
                    const SizedBox(height: 10),
                    MyInputWidget(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: fCnpj,
                      hintText: 'Digite o CNPJ da sua Empresa',
                      label: 'CNPJ',
                      textEditingController: cnpjController,
                      formKey: gkCnpj,
                      keyboardType: TextInputType.number,
                      campoVazio: 'CNPJ não pode ser em branco',
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CnpjInputFormatter(),
                      ],
                      onFieldSubmitted: (value) {
                        fUser.requestFocus();
                      },
                    ),
                    const SizedBox(height: 10),
                    MyInputWidget(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: fUser,
                      hintText: 'Digite seu Usuário',
                      label: 'Usuário',
                      textEditingController: userController,
                      campoVazio: 'Usuário não pode ser em branco',
                      formKey: gkUser,
                      inputFormaters: [UpperCaseTextFormatter()],
                      onFieldSubmitted: (value) {
                        fPassword.requestFocus();
                      },
                    ),
                    const SizedBox(height: 10),
                    MyInputWidget(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: fPassword,
                      hintText: 'Digite sua Senha',
                      obscureText: visiblePassword,
                      label: 'Senha',
                      campoVazio: 'Senha não pode ser em branco',
                      textEditingController: passwordController,
                      formKey: gkPassword,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                        child: Icon(
                          !visiblePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 25,
                          color: !visiblePassword
                              ? AppTheme.colors.primary
                              : const Color(0xFF666666),
                        ),
                        onTap: () {
                          visiblePassword = !visiblePassword;
                          setState(() {});
                        },
                      ),
                      inputFormaters: [UpperCaseTextFormatter()],
                      onFieldSubmitted: (value) {
                        if (!gkCnpj.currentState!.validate() ||
                            !gkUser.currentState!.validate() ||
                            !gkPassword.currentState!.validate()) {
                          return;
                        }

                        FocusScope.of(context).requestFocus(FocusNode());

                        widget.verifyLicenseBloc.add(
                          VerifyLicenseEvent(
                            id: _infoDeviceEntity.id,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<AuthBloc, AuthStates>(
                        bloc: widget.authBloc,
                        builder: (context, state) {
                          return BlocBuilder<VerifyLicenseBloc,
                                  VerifyLicenseStates>(
                              bloc: widget.verifyLicenseBloc,
                              builder: (context, stateLicense) {
                                return GestureDetector(
                                  onTap: stateLicense
                                              is! VerifyLicenseLoadingState &&
                                          state is! AuthLoadingState &&
                                          state is! AuthSuccessState &&
                                          stateLicense
                                              is! VerifyLicenseActiveState
                                      ? () async {
                                          if (!gkCnpj.currentState!.validate() ||
                                              !gkUser.currentState!
                                                  .validate() ||
                                              !gkPassword.currentState!
                                                  .validate()) {
                                            return;
                                          }

                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());

                                          widget.verifyLicenseBloc.add(
                                            VerifyLicenseEvent(
                                              id: _infoDeviceEntity.id,
                                            ),
                                          );
                                        }
                                      : null,
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppTheme.colors.backgroundButton,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 2,
                                          offset: Offset(0, 2),
                                          color: Colors.black26,
                                        )
                                      ],
                                    ),
                                    height: 40,
                                    duration: const Duration(milliseconds: 600),
                                    width: stateLicense
                                                is VerifyLicenseLoadingState ||
                                            state is AuthLoadingState ||
                                            state is AuthSuccessState
                                        ? 40
                                        : context.screenWidth,
                                    child: stateLicense
                                                is VerifyLicenseLoadingState ||
                                            state is AuthLoadingState
                                        ? const Center(
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : state is AuthSuccessState
                                            ? Center(
                                                child: Icon(
                                                  Icons.check_rounded,
                                                  color:
                                                      AppTheme.colors.primary,
                                                ),
                                              )
                                            : Text(
                                                'Entrar',
                                                style: AppTheme.textStyles
                                                    .labelButtonLogin,
                                              ),
                                  ),
                                );
                              });
                        }),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await mostraDialogCodigo(_infoDeviceEntity);
                      },
                      child: const Text('Licença para acessar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        mostraDialogDemonstracao();
                      },
                      child: const Text('Versão de demonstração'),
                    ),
                  ],
                ),
                Text(
                  'EL Sistemas - 2022 - 54 3364-1588',
                  style: AppTheme.textStyles.textoSairApp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
