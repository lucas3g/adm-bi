import 'package:adm_bi/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';

abstract class VendasStates {
  final List<Vendas> vendas;
  final int ccusto;

  VendasStates({required this.vendas, required this.ccusto});

  VendasSuccessState success({List<Vendas>? vendas, int? ccusto}) {
    return VendasSuccessState(
      vendas: vendas ?? this.vendas,
      ccusto: ccusto ?? this.ccusto,
    );
  }

  VendasLoadingState loading() {
    return VendasLoadingState(
      vendas: vendas,
      ccusto: ccusto,
    );
  }

  VendasErrorState error(String message) {
    return VendasErrorState(
      message: message,
      vendas: vendas,
      ccusto: ccusto,
    );
  }

  List<Vendas> get filtredList {
    if (ccusto == 0) {
      return vendas;
    }

    return vendas.where((venda) => (venda.ccusto == ccusto)).toList();
  }
}

class VendasInitialState extends VendasStates {
  VendasInitialState() : super(vendas: [], ccusto: 0);
}

class VendasLoadingState extends VendasStates {
  VendasLoadingState({
    required super.vendas,
    required super.ccusto,
  });
}

class VendasSuccessState extends VendasStates {
  VendasSuccessState({
    required super.vendas,
    required super.ccusto,
  });
}

class VendasErrorState extends VendasStates {
  final String message;

  VendasErrorState({
    required this.message,
    required super.vendas,
    required super.ccusto,
  });
}
