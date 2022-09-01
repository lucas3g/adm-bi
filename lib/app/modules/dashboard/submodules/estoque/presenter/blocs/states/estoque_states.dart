import 'package:adm_bi/app/modules/dashboard/submodules/estoque/domain/entities/estoque_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/estoque/infra/adapters/estoque_adapter.dart';
import 'package:adm_bi/app/utils/formatters.dart';

abstract class EstoqueStates {
  final List<Estoque> estoques;
  final int ccusto;
  final String filtro;

  EstoqueStates(
      {required this.estoques, required this.ccusto, required this.filtro});

  EstoqueSuccessState success(
      {List<Estoque>? estoques, int? ccusto, String? filtro}) {
    return EstoqueSuccessState(
      estoques: estoques ?? this.estoques,
      ccusto: ccusto ?? this.ccusto,
      filtro: filtro ?? this.filtro,
    );
  }

  EstoqueFilteredState filtered(
      {List<Estoque>? estoques, int? ccusto, String? filtro}) {
    return EstoqueFilteredState(
      estoques: estoques ?? this.estoques,
      ccusto: ccusto ?? this.ccusto,
      filtro: filtro ?? this.filtro,
    );
  }

  EstoqueLoadingState loading() {
    return EstoqueLoadingState(
      estoques: estoques,
      ccusto: ccusto,
      filtro: filtro,
    );
  }

  EstoqueErrorState error(String message) {
    return EstoqueErrorState(
      message: message,
      estoques: estoques,
      ccusto: ccusto,
      filtro: filtro,
    );
  }

  List<Estoque> get filtredList {
    if (ccusto == 0 && filtro.isEmpty) {
      return estoques;
    }

    if (ccusto > 0 && filtro.isEmpty) {
      return estoques
          .where(
            (cr) => (cr.ccusto == ccusto),
          )
          .toList();
    }

    if (ccusto == -1) {
      List<Map<String, dynamic>>? listEstoque = [];

      for (var estoque in estoques) {
        if (listEstoque
            .map((e) => e['DESCRICAO'])
            .contains(estoque.descricao)) {
          listEstoque[listEstoque
                  .indexWhere((e) => e['DESCRICAO'] == estoque.descricao)]
              ["EST_ATUAL"] += estoque.estoque;
        } else {
          listEstoque.add(
            {
              "CCUSTO": -1,
              "DESCRICAO": estoque.descricao,
              "EST_ATUAL": estoque.estoque
            },
          );
        }
      }

      final listEstoquesFinal =
          listEstoque.map(EstoqueAdapter.fromMap).toList();

      if (filtro.isNotEmpty) {
        return listEstoquesFinal
            .where(
              (est) => (est.descricao.toLowerCase().removeAcentos().contains(
                    filtro.toLowerCase().removeAcentos(),
                  )),
            )
            .toList();
      }

      return listEstoquesFinal;
    }

    return estoques
        .where(
          (est) => (est.ccusto == ccusto &&
              est.descricao.toLowerCase().removeAcentos().contains(
                    filtro.toLowerCase().removeAcentos(),
                  )),
        )
        .toList();
  }
}

class EstoqueInitialState extends EstoqueStates {
  EstoqueInitialState() : super(estoques: [], ccusto: 0, filtro: '');
}

class EstoqueLoadingState extends EstoqueStates {
  EstoqueLoadingState({
    required super.estoques,
    required super.ccusto,
    required super.filtro,
  });
}

class EstoqueFilteredState extends EstoqueStates {
  EstoqueFilteredState({
    required super.estoques,
    required super.ccusto,
    required super.filtro,
  });
}

class EstoqueSuccessState extends EstoqueStates {
  EstoqueSuccessState({
    required super.estoques,
    required super.ccusto,
    required super.filtro,
  });
}

class EstoqueErrorState extends EstoqueStates {
  final String message;

  EstoqueErrorState({
    required this.message,
    required super.estoques,
    required super.ccusto,
    required super.filtro,
  });
}
