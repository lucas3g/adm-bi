import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    Modular.to.navigate('/auth/');
  }

  @override
  void initState() {
    super.initState();

    init();
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
