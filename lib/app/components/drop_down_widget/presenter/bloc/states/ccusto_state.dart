import 'package:app_demonstrativo/app/components/drop_down_widget/domain/entities/ccusto_entity.dart';

abstract class CCustoStates {
  final List<CCusto> ccustos;
  final int selectedEmpresa;

  CCustoStates({required this.ccustos, required this.selectedEmpresa});

  CCustoSuccessState success({List<CCusto>? ccustos, int? selectedEmpresa}) {
    return CCustoSuccessState(
      ccustos: ccustos ?? this.ccustos,
      selectedEmpresa: selectedEmpresa ?? this.selectedEmpresa,
    );
  }

  CCustoLoadingState loading() {
    return CCustoLoadingState(
      ccustos: ccustos,
      selectedEmpresa: selectedEmpresa,
    );
  }

  CCustoErrorState error(String message) {
    return CCustoErrorState(
      message: message,
      ccustos: ccustos,
      selectedEmpresa: selectedEmpresa,
    );
  }
}

class CCustoInitialState extends CCustoStates {
  CCustoInitialState() : super(ccustos: [], selectedEmpresa: 0);
}

class CCustoLoadingState extends CCustoStates {
  CCustoLoadingState({
    required super.ccustos,
    required super.selectedEmpresa,
  });
}

class CCustoSuccessState extends CCustoStates {
  CCustoSuccessState({
    required super.ccustos,
    required super.selectedEmpresa,
  });
}

class CCustoErrorState extends CCustoStates {
  final String message;

  CCustoErrorState({
    required this.message,
    required super.ccustos,
    required super.selectedEmpresa,
  });
}
