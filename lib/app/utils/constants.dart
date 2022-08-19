import 'package:flutter/cupertino.dart';

class Constants {
  static String urlVendasDiarias = 'vendas/vendas';
  static String urlVendasLucro = 'vendas/projecao';
  static String urlVendasGrafico = 'vendas/grafico';
  static String urlMovimento = 'movimento/saldo';
  static String urlResumoFP = 'formaspag/resumo';
  static String urlCR = 'contas/cr';
  static String urlCP = 'contas/cp';
  static String urlEstoque = 'mercadorias/estoque';
}

extension ContextExtensions on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}
