import 'package:adm_bi/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_grafico_usecase.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/events/grafico_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/states/grafico_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GraficoBloc extends Bloc<GraficoEvents, GraficoStates> {
  final GetVendasGraficoUseCase getVendasGraficoUseCase;

  GraficoBloc({
    required this.getVendasGraficoUseCase,
  }) : super(GraficoInitialState()) {
    on<GetGraficoEvent>(_getVendasGrafico);
    on<GraficoFilterEvent>(_graficoFilter);
  }

  Future _getVendasGrafico(GetGraficoEvent event, emit) async {
    emit(state.loading());
    final result = await getVendasGraficoUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) {
        _graficoFilter(
          GraficoFilterEvent(
              ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa),
          emit,
        );
        return emit(state.success(grafico: r));
      },
    );
  }

  Future _graficoFilter(GraficoFilterEvent event, emit) async {
    emit(state.success(ccusto: event.ccusto));
  }
}
