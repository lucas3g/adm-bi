// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:app_demonstrativo/app/modules/auth/domain/entities/info_device_entity.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/events/info_device_events.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/events/verify_license_events.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/states/info_device_states.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/states/verify_license_states.dart';
import 'package:asuka/asuka.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import 'package:app_demonstrativo/app/components/my_input_widget.dart';
import 'package:app_demonstrativo/app/core_module/services/shared_preferences/adapters/shared_params.dart';
import 'package:app_demonstrativo/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:app_demonstrativo/app/modules/auth/domain/entities/user_entity.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/auth_bloc.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/events/auth_events.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/info_device_bloc.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/states/auth_states.dart';
import 'package:app_demonstrativo/app/modules/auth/presenter/blocs/verify_license_bloc.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:app_demonstrativo/app/utils/my_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

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
<<<<<<< HEAD
                                'Código para Licença App DashBoard: ${_infoDeviceEntity.id}',
=======
                                'Código para Licença App Dashboard: ${_infoDeviceEntity.id}',
>>>>>>> f15ba57e8628014216254051e200d31f06d9c1e4
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

  Future<void> openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(
          Uri.parse(
            whatsappURLIos,
          ),
        );
      } else {
        MySnackBar(message: "Whatsapp não está instalado");
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        MySnackBar(message: "Whatsapp não está instalado");
      }
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
                Column(
                  children: [
                    Lottie.asset(
                      'assets/images/logo.json',
                      height: context.screenHeight * .27,
                    ),
                    const Divider(),
                    Text(
                      'Demonstrativo',
                      style: AppTheme.textStyles.titleSplash,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Entre com sua conta',
                      style: AppTheme.textStyles.textoSairApp,
                    ),
                    const SizedBox(height: 10),
                    MyInputWidget(
                      onTap: () {
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
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
                    ),
                    const SizedBox(height: 10),
                    MyInputWidget(
                      onTap: () {
                        scrollController.animateTo(
                          50,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: fUser,
                      hintText: 'Digite seu Usuário',
                      label: 'Usuário',
                      textEditingController: userController,
                      campoVazio: 'Usuário não pode ser em branco',
                      formKey: gkUser,
                      inputFormaters: [UpperCaseTextFormatter()],
                    ),
                    const SizedBox(height: 10),
                    MyInputWidget(
                      onTap: () {
                        scrollController.animateTo(
                          100,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
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
                                  onTap: state is! AuthLoadingState
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
                    )
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
