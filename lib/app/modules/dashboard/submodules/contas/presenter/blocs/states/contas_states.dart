import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';

abstract class ContasStates {
  final List<Contas> contas;
  final int ccusto;

  ContasStates({required this.contas, required this.ccusto});

  ContasSuccessState success({List<Contas>? contas, int? ccusto}) {
    return ContasSuccessState(
      contas: contas ?? this.contas,
      ccusto: ccusto ?? this.ccusto,
    );
  }

  ContasLoadingState loading() {
    return ContasLoadingState(
      contas: contas,
      ccusto: ccusto,
    );
  }

  ContasErrorState error(String message) {
    return ContasErrorState(
      message: message,
      contas: contas,
      ccusto: ccusto,
    );
  }

  List<Contas> get filtredList {
    if (ccusto == 0) {
      return contas;
    }

    return contas.where((conta) => (conta.ccusto == ccusto)).toList();
  }
}

class ContasInitialState extends ContasStates {
  ContasInitialState() : super(contas: [], ccusto: 0);
}

class ContasLoadingState extends ContasStates {
  ContasLoadingState({
    required super.contas,
    required super.ccusto,
  });
}

class ContasSuccessState extends ContasStates {
  ContasSuccessState({
    required super.contas,
    required super.ccusto,
  });
}

class ContasErrorState extends ContasStates {
  final String message;

  ContasErrorState({
    required this.message,
    required super.contas,
    required super.ccusto,
  });
}
