import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_grafico_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/vendas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/vendas_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VendasBloc extends Bloc<VendasEvents, VendasStates> {
  final GetVendasUseCase getVendasUseCase;
  final GetVendasGraficoUseCase getVendasGraficoUseCase;

  VendasBloc({
    required this.getVendasUseCase,
    required this.getVendasGraficoUseCase,
  }) : super(VendasInitialState()) {
    on<GetVendasEvent>(_getVendas);
    on<GetVendasGraficoEvent>(_getVendasGrafico);
  }

  Future _getVendas(GetVendasEvent event, emit) async {
    final result = await getVendasUseCase();

    result.fold(
      (l) => emit(VendasErrorState(message: l.message)),
      (r) => emit(VendasLastTenSuccessState(vendas: r)),
    );
  }

  Future _getVendasGrafico(GetVendasGraficoEvent event, emit) async {
    final result = await getVendasGraficoUseCase();

    result.fold(
      (l) => emit(VendasErrorState(message: l.message)),
      (r) => emit(VendasSevenDaysSuccessState(vendasGrafico: r)),
    );
  }
}
