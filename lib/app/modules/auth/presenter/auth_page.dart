import 'package:app_demonstrativo/app/components/my_elevated_button_widget.dart';
import 'package:app_demonstrativo/app/components/my_input_widget.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

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
                    MyElevatedButtonWidget(
                      label: const Text('Entrar'),
                      onPressed: () {
                        Modular.to.navigate('/dash/');
                      },
                      height: 40,
                      width: context.screenWidth,
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
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
