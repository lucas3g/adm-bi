import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/domain/usecases/get_resumo_cr_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/blocs/events/cr_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/blocs/states/cr_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CRBloc extends Bloc<CREvents, CRStates> {
  final GetResumoCRUseCase getResumoCRUseCase;

  CRBloc({
    required this.getResumoCRUseCase,
  }) : super(CRInitialState()) {
    on<GetCREvent>(_getResumoCR);
    on<CRFilterEvent>(_filterCR);
  }

  Future _getResumoCR(GetCREvent event, emit) async {
    emit(state.loading());
    final result = await getResumoCRUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) {
        // _filterCR(
        //     CRFilterEvent(
        //         ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa,
        //         filtro: ''),
        //     emit);
        return emit(state.success(crs: r));
      },
    );
  }

  Future _filterCR(CRFilterEvent event, emit) async {
    emit(state.filtered(ccusto: event.ccusto, filtro: event.filtro));
  }
}
