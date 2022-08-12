import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';

abstract class VendasStates {}

class VendasInitialState extends VendasStates {}

class VendasLoadingState extends VendasStates {}

class VendasSuccessState extends VendasStates {
  final List<Vendas> vendas;

  VendasSuccessState({required this.vendas});
}

class VendasErrorState extends VendasStates {
  final String message;

  VendasErrorState({required this.message});
}
