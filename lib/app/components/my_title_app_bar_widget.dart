import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyTitleAppBarWidget extends StatelessWidget {
  final int index;
  const MyTitleAppBarWidget({Key? key, required this.index}) : super(key: key);

  Widget retornaTitle() {
    if (index == 0) {
      return Text(
        'Resumo de Vendas',
        style: AppTheme.textStyles.titleAppBar,
        textAlign: TextAlign.center,
      );
    }
    if (index == 1) {
      return Text(
        'Saldo a Receber / Pagar',
        style: AppTheme.textStyles.titleAppBar,
        textAlign: TextAlign.center,
      );
    }
    if (index == 2) {
      return Text(
        'Resumo Formas Pag.',
        style: AppTheme.textStyles.titleAppBar,
        textAlign: TextAlign.center,
      );
    }
    if (index == 3) {
      return Text(
        'Contas a Receber',
        style: AppTheme.textStyles.titleAppBar,
        textAlign: TextAlign.center,
      );
    }
    if (index == 4) {
      return Text(
        'Contas a Pagar',
        style: AppTheme.textStyles.titleAppBar,
        textAlign: TextAlign.center,
      );
    }
    if (index == 5) {
      return Text(
        'Estoque',
        style: AppTheme.textStyles.titleAppBar,
        textAlign: TextAlign.center,
      );
    }
    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
    return retornaTitle();
  }
}
