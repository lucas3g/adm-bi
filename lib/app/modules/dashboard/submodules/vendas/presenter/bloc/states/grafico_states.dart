import 'package:adm_bi/app/modules/dashboard/submodules/vendas/domain/entities/grafico_vendas.dart';

abstract class GraficoStates {
  final List<GraficoVendas> grafico;
  final int ccusto;

  GraficoStates({required this.grafico, required this.ccusto});

  GraficoSuccessState success({List<GraficoVendas>? grafico, int? ccusto}) {
    return GraficoSuccessState(
      grafico: grafico ?? this.grafico,
      ccusto: ccusto ?? this.ccusto,
    );
  }

  GraficoLoadingState loading() {
    return GraficoLoadingState(
      grafico: grafico,
      ccusto: ccusto,
    );
  }

  GraficoErrorState error(String message) {
    return GraficoErrorState(
      message: message,
      grafico: grafico,
      ccusto: ccusto,
    );
  }

  List<GraficoVendas> get filtredList {
    if (ccusto == 0) {
      return grafico;
    }

    return grafico.where((venda) => (venda.ccusto == ccusto)).toList();
  }
}

class GraficoInitialState extends GraficoStates {
  GraficoInitialState() : super(grafico: [], ccusto: 0);
}

class GraficoLoadingState extends GraficoStates {
  GraficoLoadingState({
    required super.grafico,
    required super.ccusto,
  });
}

class GraficoSuccessState extends GraficoStates {
  GraficoSuccessState({
    required super.grafico,
    required super.ccusto,
  });
}

class GraficoErrorState extends GraficoStates {
  final String message;

  GraficoErrorState({
    required this.message,
    required super.grafico,
    required super.ccusto,
  });
}
