// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_demonstrativo/app/components/drop_down_widget/domain/entities/ccusto_entity.dart';

abstract class CCustoStates {
  final int selectedEmpresa;

  CCustoStates({
    required this.selectedEmpresa,
  });
}

class CCustoInitialState extends CCustoStates {
  CCustoInitialState({required super.selectedEmpresa});
}

class CCustoLoadingState extends CCustoStates {
  CCustoLoadingState({required super.selectedEmpresa});
}

class CCustoSuccessState extends CCustoStates {
  final List<CCusto>? ccustos;
  final int? initialValue;

  CCustoSuccessState({
    this.ccustos,
    this.initialValue,
    required super.selectedEmpresa,
  });
}

class CCustoErrorState extends CCustoStates {
  final String message;

  CCustoErrorState({
    required this.message,
    required super.selectedEmpresa,
  });
}
