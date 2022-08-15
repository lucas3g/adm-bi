// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';

abstract class ContasStates {}

class ContasInitialState extends ContasStates {}

class ContasLoadingState extends ContasStates {}

class ContasSuccessState extends ContasStates {
  final List<Contas> contas;

  ContasSuccessState({
    required this.contas,
  });
}

class ContasErrorState extends ContasStates {
  final String message;

  ContasErrorState({
    required this.message,
  });
}
