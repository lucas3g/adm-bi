import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

abstract class AppTextStyles {
  TextStyle get button;
  TextStyle get titleAppBar;
  TextStyle get titleSplash;
  TextStyle get titleNumeroViagem;
  TextStyle get titleEstoque;
  TextStyle get titleViagem;
  TextStyle get titleImageNaoEncontrada;
  TextStyle get titleGraficoVendas;
  TextStyle get titleResumoVendas;
  TextStyle get textoCadastroSucesso;
  TextStyle get textoTermo;
  TextStyle get textoRadioList;
  TextStyle get textoConfirmarData;
  TextStyle get titleHeaderDashBoard;
  TextStyle get subTitleHeaderDashBoard;
  TextStyle get textoSairApp;
  TextStyle get valorCRCP;
  TextStyle get subTitleCRCP;
  TextStyle get saldoClienteCRCP;
  TextStyle get valorResumoVendas;
  TextStyle get totalGeralClienteCRCP;
  TextStyle get titleTotalGeralCRCP;
  TextStyle get titleResumoFp;
  TextStyle get labelButtonLogin;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get button => GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.colors.button);

  @override
  TextStyle get titleAppBar => GoogleFonts.inter(
      fontSize: 20,
      color: AppTheme.colors.titleAppBar,
      fontWeight: FontWeight.w700);

  @override
  TextStyle get titleSplash => GoogleFonts.montserrat(
      fontSize: 30,
      color: AppTheme.colors.primary,
      fontWeight: FontWeight.w700);

  @override
  TextStyle get titleNumeroViagem =>
      GoogleFonts.montserrat(fontSize: 14, color: Colors.black);

  @override
  TextStyle get titleEstoque => GoogleFonts.montserrat(
        fontSize: 16,
        color: AppTheme.colors.titleEstoque,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleViagem => GoogleFonts.montserrat(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  TextStyle get titleImageNaoEncontrada => GoogleFonts.montserrat(
      fontSize: 12, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  TextStyle get titleGraficoVendas => GoogleFonts.montserrat(
        fontSize: 13,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      );

  @override
  TextStyle get textoCadastroSucesso => GoogleFonts.montserrat(
      fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700);

  @override
  TextStyle get textoTermo => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
      );

  @override
  TextStyle get textoRadioList => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get titleHeaderDashBoard => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get subTitleHeaderDashBoard => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get textoConfirmarData => GoogleFonts.montserrat(
        fontSize: 14,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get textoSairApp => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get valorCRCP => GoogleFonts.montserrat(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get subTitleCRCP => GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.white,
      );

  @override
  TextStyle get saldoClienteCRCP => GoogleFonts.montserrat(
        fontSize: 16,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get totalGeralClienteCRCP => GoogleFonts.montserrat(
        fontSize: 30,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleTotalGeralCRCP => GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get valorResumoVendas => GoogleFonts.montserrat(
        fontSize: 14,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleResumoVendas => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get titleResumoFp => GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get labelButtonLogin => GoogleFonts.roboto(
        fontSize: 14,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );
}
