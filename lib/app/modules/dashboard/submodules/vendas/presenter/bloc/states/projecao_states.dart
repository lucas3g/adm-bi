import 'package:adm_bi/app/modules/dashboard/submodules/vendas/domain/entities/projecao_vendas.dart';

abstract class ProjecaoStates {
  final List<ProjecaoVendas> projecao;
  final int ccusto;

  ProjecaoStates({required this.projecao, required this.ccusto});

  ProjecaoSuccessState success({List<ProjecaoVendas>? projecao, int? ccusto}) {
    return ProjecaoSuccessState(
      projecao: projecao ?? this.projecao,
      ccusto: ccusto ?? this.ccusto,
    );
  }

  ProjecaoLoadingState loading() {
    return ProjecaoLoadingState(
      projecao: projecao,
      ccusto: ccusto,
    );
  }

  ProjecaoErrorState error(String message) {
    return ProjecaoErrorState(
      message: message,
      projecao: projecao,
      ccusto: ccusto,
    );
  }

  List<ProjecaoVendas> get filtredList {
    if (ccusto == 0) {
      return projecao;
    }

    if (ccusto == -1) {
      final List<ProjecaoVendas> proj = [];

      proj.add(
        ProjecaoVendas(
          ccusto: -1,
          totalDiario: projecao
              .map((e) => e.totalDiario)
              .reduce((value, element) => value + element),
          totalMes: projecao
              .map((e) => e.totalMes)
              .reduce((value, element) => value + element),
          lucro: projecao
              .map((e) => e.lucro)
              .reduce((value, element) => value + element),
        ),
      );

      return proj;
    }

    return projecao.where((venda) => (venda.ccusto == ccusto)).toList();
  }
}

class ProjecaoInitialState extends ProjecaoStates {
  ProjecaoInitialState() : super(projecao: [], ccusto: 0);
}

class ProjecaoLoadingState extends ProjecaoStates {
  ProjecaoLoadingState({
    required super.projecao,
    required super.ccusto,
  });
}

class ProjecaoSuccessState extends ProjecaoStates {
  ProjecaoSuccessState({
    required super.projecao,
    required super.ccusto,
  });
}

class ProjecaoErrorState extends ProjecaoStates {
  final String message;

  ProjecaoErrorState({
    required this.message,
    required super.projecao,
    required super.ccusto,
  });
}
