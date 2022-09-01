// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adm_bi/app/modules/dashboard/submodules/resumo_formas/domain/entities/formas_pag_entity.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/resumo_formas/infra/adapters/formas_pag_adapter.dart';

abstract class FormasPagStates {
  final List<FormasPag> formasPag;
  final int ccusto;

  FormasPagStates({
    required this.formasPag,
    required this.ccusto,
  });

  FormasPagSuccessState success({List<FormasPag>? formasPag, int? ccusto}) {
    return FormasPagSuccessState(
      formasPag: formasPag ?? this.formasPag,
      ccusto: ccusto ?? this.ccusto,
    );
  }

  FormasPagLoadingState loading() {
    return FormasPagLoadingState(
      formasPag: formasPag,
      ccusto: ccusto,
    );
  }

  FormasPagErrorState error(String message) {
    return FormasPagErrorState(
      message: message,
      formasPag: formasPag,
      ccusto: ccusto,
    );
  }

  List<FormasPag> get filtredList {
    if (ccusto == 0) {
      return formasPag;
    }

    if (ccusto == -1) {
      List<Map<String, dynamic>>? listFPs = [];

      for (var forma in formasPag) {
        if (listFPs.map((e) => e['FORMA_PAG']).contains(forma.formaPag)) {
          listFPs[listFPs.indexWhere((e) => e['FORMA_PAG'] == forma.formaPag)]
              ["TOTAL_FORMA"] += forma.totalForma;
        } else {
          listFPs.add(
            {
              "LOCAL": -1,
              "FORMA_PAG": forma.formaPag,
              "CCUSTO": forma.ccusto,
              "TIPO": forma.tipo,
              "DESC_FORMA": forma.descricao,
              "TOTAL_FORMA": forma.totalForma,
            },
          );
        }
      }

      return listFPs.map(FormasPagAdapter.fromMap).toList();
    }

    return formasPag.where((forma) => (forma.ccusto == ccusto)).toList();
  }
}

class FormasPagInitialState extends FormasPagStates {
  FormasPagInitialState() : super(formasPag: [], ccusto: 0);
}

class FormasPagLoadingState extends FormasPagStates {
  FormasPagLoadingState({
    required super.formasPag,
    required super.ccusto,
  });
}

class FormasPagSuccessState extends FormasPagStates {
  FormasPagSuccessState({
    required super.formasPag,
    required super.ccusto,
  });
}

class FormasPagErrorState extends FormasPagStates {
  final String message;

  FormasPagErrorState({
    required this.message,
    required super.formasPag,
    required super.ccusto,
  });
}
