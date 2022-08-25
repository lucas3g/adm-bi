import 'package:speed_bi/app/modules/dashboard/submodules/cp/domain/entities/cp_entity.dart';
import 'package:speed_bi/app/utils/formatters.dart';

abstract class CPStates {
  final List<CP> cps;
  final int ccusto;
  final String filtro;

  CPStates({required this.cps, required this.ccusto, required this.filtro});

  CPSuccessState success({List<CP>? cps, int? ccusto, String? filtro}) {
    return CPSuccessState(
      cps: cps ?? this.cps,
      ccusto: ccusto ?? this.ccusto,
      filtro: filtro ?? this.filtro,
    );
  }

  CPFilteredState filtered({List<CP>? cps, int? ccusto, String? filtro}) {
    return CPFilteredState(
      cps: cps ?? this.cps,
      ccusto: ccusto ?? this.ccusto,
      filtro: filtro ?? this.filtro,
    );
  }

  CPLoadingState loading() {
    return CPLoadingState(
      cps: cps,
      ccusto: ccusto,
      filtro: filtro,
    );
  }

  CPErrorState error(String message) {
    return CPErrorState(
      message: message,
      cps: cps,
      ccusto: ccusto,
      filtro: filtro,
    );
  }

  List<CP> get filtredList {
    if (ccusto == 0 && filtro.isEmpty) {
      return cps;
    }

    if (ccusto > 0 && filtro.isEmpty) {
      return cps
          .where(
            (cp) => (cp.ccusto == ccusto),
          )
          .toList();
    }

    return cps
        .where(
          (cp) => (cp.ccusto == ccusto &&
              cp.nome.toLowerCase().removeAcentos().contains(
                    filtro.toLowerCase().removeAcentos(),
                  )),
        )
        .toList();
  }

  double get saldoCp {
    return filtredList
        .map((cr) => cr.valor)
        .reduce((value, element) => value + element)
        .toDouble();
  }
}

class CPInitialState extends CPStates {
  CPInitialState() : super(cps: [], ccusto: 0, filtro: '');
}

class CPLoadingState extends CPStates {
  CPLoadingState({
    required super.cps,
    required super.ccusto,
    required super.filtro,
  });
}

class CPSuccessState extends CPStates {
  CPSuccessState({
    required super.cps,
    required super.ccusto,
    required super.filtro,
  });
}

class CPFilteredState extends CPStates {
  CPFilteredState({
    required super.cps,
    required super.ccusto,
    required super.filtro,
  });
}

class CPErrorState extends CPStates {
  final String message;

  CPErrorState({
    required this.message,
    required super.cps,
    required super.ccusto,
    required super.filtro,
  });
}
