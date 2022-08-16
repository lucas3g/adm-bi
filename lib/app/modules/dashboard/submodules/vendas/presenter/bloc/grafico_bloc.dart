import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_grafico_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/grafico_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/grafico_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraficoBloc extends Bloc<GraficoEvents, GraficoStates> {
  final GetVendasGraficoUseCase getVendasGraficoUseCase;

  GraficoBloc({
    required this.getVendasGraficoUseCase,
  }) : super(GraficoInitialState()) {
    on<GetGraficoEvent>(_getVendasGrafico);
    on<GraficoFilterEvent>(_graficoFilter);
  }

  Future _getVendasGrafico(GetGraficoEvent event, emit) async {
    final result = await getVendasGraficoUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) => emit(state.success(grafico: r)),
    );
  }

  Future _graficoFilter(GraficoFilterEvent event, emit) async {
    emit(state.loading());
    emit(state.success(ccusto: event.ccusto));
  }
}
