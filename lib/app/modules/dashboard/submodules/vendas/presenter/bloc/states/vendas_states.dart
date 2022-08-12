import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/grafico_vendas.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';

abstract class VendasStates {}

class VendasInitialState extends VendasStates {}

class VendasLoadingState extends VendasStates {}

class VendasLastTenSuccessState extends VendasStates {
  final List<Vendas> vendas;

  VendasLastTenSuccessState({required this.vendas});
}

class VendasSevenDaysSuccessState extends VendasStates {
  final List<GraficoVendas> vendasGrafico;

  VendasSevenDaysSuccessState({required this.vendasGrafico});
}

class VendasErrorState extends VendasStates {
  final String message;

  VendasErrorState({required this.message});
}
