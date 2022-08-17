import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/domain/entities/cr_entity.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';

abstract class CRStates {
  final List<CR> crs;
  final int ccusto;
  final String filtro;

  CRStates({required this.crs, required this.ccusto, required this.filtro});

  CRSuccessState success({List<CR>? crs, int? ccusto, String? filtro}) {
    return CRSuccessState(
      crs: crs ?? this.crs,
      ccusto: ccusto ?? this.ccusto,
      filtro: filtro ?? this.filtro,
    );
  }

  CRFilteredState filtered({List<CR>? crs, int? ccusto, String? filtro}) {
    return CRFilteredState(
      crs: crs ?? this.crs,
      ccusto: ccusto ?? this.ccusto,
      filtro: filtro ?? this.filtro,
    );
  }

  CRLoadingState loading() {
    return CRLoadingState(
      crs: crs,
      ccusto: ccusto,
      filtro: filtro,
    );
  }

  CRErrorState error(String message) {
    return CRErrorState(
      message: message,
      crs: crs,
      ccusto: ccusto,
      filtro: filtro,
    );
  }

  List<CR> get filtredList {
    if (ccusto == 0 && filtro.isEmpty) {
      return crs;
    }

    if (ccusto > 0 && filtro.isEmpty) {
      return crs
          .where(
            (cr) => (cr.ccusto == ccusto),
          )
          .toList();
    }

    return crs
        .where(
          (cr) => (cr.ccusto == ccusto &&
              cr.nome.toLowerCase().removeAcentos().contains(
                    filtro.toLowerCase().removeAcentos(),
                  )),
        )
        .toList();
  }

  double get saldoCR {
    return filtredList
        .map((cr) => cr.valor)
        .reduce((value, element) => value + element)
        .toDouble();
  }
}

class CRInitialState extends CRStates {
  CRInitialState() : super(crs: [], ccusto: 0, filtro: '');
}

class CRLoadingState extends CRStates {
  CRLoadingState({
    required super.crs,
    required super.ccusto,
    required super.filtro,
  });
}

class CRSuccessState extends CRStates {
  CRSuccessState({
    required super.crs,
    required super.ccusto,
    required super.filtro,
  });
}

class CRFilteredState extends CRStates {
  CRFilteredState({
    required super.crs,
    required super.ccusto,
    required super.filtro,
  });
}

class CRErrorState extends CRStates {
  final String message;

  CRErrorState({
    required this.message,
    required super.crs,
    required super.ccusto,
    required super.filtro,
  });
}
