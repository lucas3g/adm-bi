// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Formatters {}

extension MoneyDouble on double {
  String reais() {
    final format = NumberFormat.simpleCurrency(locale: 'pt_br');
    return format.format(this);
  }
}

extension LitroDouble on double {
  String Litros() {
    final format = NumberFormat.simpleCurrency(locale: 'pt_br', name: '');
    return format.format(this);
  }
}

extension Estoques on String {
  double estoque() {
    final format = NumberFormat('###,###,##0.00', 'pt_BR');

    return format.parse(this).toDouble();
  }
}

extension ReaisSemR on double {
  String reaisSemR() {
    final format = NumberFormat('###,###,##0.00', 'pt_BR');

    return format.format(this);
  }
}

extension LitroInt on int {
  String LitrosInt() {
    final format = NumberFormat.simpleCurrency(locale: 'pt_br', name: '');
    return format.format(this);
  }
}

extension PorcentagemDouble on double {
  String Porcentagem() {
    final format = NumberFormat.simpleCurrency(locale: 'pt_br', name: '');
    return format.format(this);
  }
}

extension DateTimeString on DateTime {
  String diaMes() {
    final format = DateFormat('d MMMM', 'pt_br');
    return format.format(this);
  }
}

extension DataString on DateTime {
  String AnoMesDia() {
    final format = DateFormat('yyyy-MM-dd');
    return format.format(this);
  }
}

extension DiaMesAnoHoraString on DateTime {
  String DiaMesAnoHora() {
    final format = DateFormat("d 'de' MMMM 'de' yyyy - HH:mm", 'pt_br');
    return format.format(this);
  }
}

extension DiaMesAnoString on DateTime {
  String DiaMesAno() {
    final format = DateFormat("d 'de' MMMM 'de' yyyy", 'pt_br');
    return format.format(this);
  }
}

extension DiaMesAnoTexto on String {
  String DiaMesAnoText() {
    final format = DateFormat('dd/MM/yyyy', 'pt_br');
    return format.format(DateTime.parse(this));
  }
}

extension DiasMesAnoDB on DateTime {
  String DiaMesAnoDB() {
    final format = DateFormat('dd/MM/yyyy', 'pt_br');
    return format.format(this);
  }
}

extension DiaString on DateTime {
  String Dia() {
    final format = DateFormat('dd');
    return format.format(this);
  }
}

extension DiaMesString on DateTime {
  String DiaMes() {
    final format = DateFormat('dd/MM');
    return format.format(this);
  }
}

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

extension RemoveAcentos on String {
  String removeAcentos() {
    late String str = this;
    var withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }

    return str;
  }
}

extension CapExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get capitalize => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

double convertToDouble(String value) {
  return NumberFormat('###,###,###', 'pt_Br').parse(value.trim()).toDouble();
}
