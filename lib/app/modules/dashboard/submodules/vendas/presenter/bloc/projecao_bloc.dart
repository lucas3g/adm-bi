import 'package:adm_bi/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/domain/usecases/get_projecao_usecase.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/events/projecao_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/states/projecao_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjecaoBloc extends Bloc<ProjecaoEvents, ProjecaoStates> {
  final GetProjecaoUseCase getProjecaoUseCase;

  ProjecaoBloc({required this.getProjecaoUseCase})
      : super(ProjecaoInitialState()) {
    on<GetProjecaoEvent>(_getProjecao);
    on<ProjecaoFilterEvent>(_projecaoFilter);
  }

  Future _getProjecao(GetProjecaoEvent event, emit) async {
    emit(state.loading());
    final result = await getProjecaoUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) {
        _projecaoFilter(
          ProjecaoFilterEvent(
              ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa),
          emit,
        );
        return emit(state.success(projecao: r));
      },
    );
  }

  Future _projecaoFilter(ProjecaoFilterEvent event, emit) async {
    emit(state.success(ccusto: event.ccusto));
  }
}
