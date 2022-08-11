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
  TextStyle get textoSairApp;
  TextStyle get textoCadastroSucesso;
  TextStyle get textoTermo;
  TextStyle get textoRadioList;
  TextStyle get textoConfirmarData;
  TextStyle get textoCancelarData;
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
      fontSize: 18,
      color: AppTheme.colors.titleEstoque,
      fontWeight: FontWeight.w700);

  @override
  TextStyle get titleViagem => GoogleFonts.montserrat(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  TextStyle get titleImageNaoEncontrada => GoogleFonts.montserrat(
      fontSize: 12, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  TextStyle get textoSairApp => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
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
  TextStyle get textoCancelarData => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
      );

  @override
  TextStyle get textoConfirmarData => GoogleFonts.montserrat(
        fontSize: 14,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.w600,
      );
}
