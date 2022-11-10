import 'package:adm_bi/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/infra/adapters/contas_adapter.dart';

abstract class ContasStates {
  final List<Contas> contas;
  final int ccusto;
  final String diaSemanaMes;

  ContasStates(
      {required this.contas, required this.ccusto, required this.diaSemanaMes});

  ContasSuccessState success(
      {List<Contas>? contas, int? ccusto, String? diaSemanaMes}) {
    return ContasSuccessState(
      contas: contas ?? this.contas,
      ccusto: ccusto ?? this.ccusto,
      diaSemanaMes: diaSemanaMes ?? this.diaSemanaMes,
    );
  }

  ContasLoadingState loading() {
    return ContasLoadingState(
      contas: contas,
      ccusto: ccusto,
      diaSemanaMes: diaSemanaMes,
    );
  }

  ContasErrorState error(String message) {
    return ContasErrorState(
      message: message,
      contas: contas,
      ccusto: ccusto,
      diaSemanaMes: diaSemanaMes,
    );
  }

  List<Contas> get filtredList {
    if (ccusto == 0) {
      return contas;
    }

    if (ccusto == -1) {
      List<Map<String, dynamic>>? listContas = [];

      for (var conta in contas) {
        if (listContas
            .map((e) => e['CARD_SUBTITLE'])
            .contains(conta.cardSubtitle)) {
          listContas[listContas
                  .indexWhere((e) => e['CARD_SUBTITLE'] == conta.cardSubtitle)]
              ["TOTAL_DIA"] += conta.totalDiario;
          listContas[listContas
                  .indexWhere((e) => e['CARD_SUBTITLE'] == conta.cardSubtitle)]
              ["TOTAL_SEMANA"] += conta.totalSemanal;
          listContas[listContas
                  .indexWhere((e) => e['CARD_SUBTITLE'] == conta.cardSubtitle)]
              ["TOTAL_MES"] += conta.totalMes;
        } else {
          listContas.add(
            {
              "CCUSTO": -1,
              "TOTAL_DIA": conta.totalDiario,
              "TOTAL_SEMANA": conta.totalSemanal,
              "TOTAL_MES": conta.totalMes,
              "CARD_SUBTITLE": conta.cardSubtitle,
              "DC": conta.dc,
              "CARD_COR": conta.cardColor.toString(),
            },
          );
        }
      }

      listContas
          .sort((a, b) => a['CARD_SUBTITLE'].compareTo(b['CARD_SUBTITLE']));

      return listContas.map(ContasAdapter.fromMap).toList();
    }

    contas.sort((a, b) => a.cardSubtitle.compareTo(b.cardSubtitle));

    return contas.where((conta) => (conta.ccusto == ccusto)).toList();
  }

  double get saldoGeral {
    late double saldo = 0;
    for (var conta
        in filtredList.where((e) => e.cardSubtitle != 'Boletos').toList()) {
      //D = CP
      if (conta.dc != 'D') {
        if (diaSemanaMes == 'Dia') {
          saldo += conta.totalDiario;
        }
        if (diaSemanaMes == 'Semana') {
          saldo += conta.totalSemanal;
        }
        if (diaSemanaMes == 'Mes') {
          saldo += conta.totalMes;
        }
      } else {
        if (diaSemanaMes == 'Dia') {
          saldo -= conta.totalDiario;
        }
        if (diaSemanaMes == 'Semana') {
          saldo -= conta.totalSemanal;
        }
        if (diaSemanaMes == 'Mes') {
          saldo -= conta.totalMes;
        }
      }
    }
    return saldo;
  }
}

class ContasInitialState extends ContasStates {
  ContasInitialState() : super(contas: [], ccusto: 0, diaSemanaMes: 'Dia');
}

class ContasLoadingState extends ContasStates {
  ContasLoadingState({
    required super.contas,
    required super.ccusto,
    required super.diaSemanaMes,
  });
}

class ContasSuccessState extends ContasStates {
  ContasSuccessState({
    required super.contas,
    required super.ccusto,
    required super.diaSemanaMes,
  });
}

class ContasErrorState extends ContasStates {
  final String message;

  ContasErrorState({
    required this.message,
    required super.contas,
    required super.ccusto,
    required super.diaSemanaMes,
  });
}
