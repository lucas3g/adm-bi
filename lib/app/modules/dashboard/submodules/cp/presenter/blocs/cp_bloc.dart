import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/domain/usecases/get_resumo_cp_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/presenter/blocs/events/cp_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/presenter/blocs/states/cp_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CPBloc extends Bloc<CPEvents, CPStates> {
  final GetResumoCPUseCase getResumoCPUseCase;

  CPBloc({
    required this.getResumoCPUseCase,
  }) : super(CPInitialState()) {
    on<GetCPEvent>(_getResumoCP);
    on<CPFilterEvent>(_filterCP);
  }

  Future _getResumoCP(GetCPEvent event, emit) async {
    emit(state.loading());
    final result = await getResumoCPUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) {
        return emit(state.success(cps: r));
      },
    );
  }

  Future _filterCP(CPFilterEvent event, emit) async {
    emit(state.filtered(ccusto: event.ccusto, filtro: event.filtro));
  }
}
