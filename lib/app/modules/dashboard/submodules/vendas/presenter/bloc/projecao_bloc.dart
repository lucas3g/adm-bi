import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/usecases/get_projecao_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/projecao_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/projecao_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      (r) => emit(state.success(projecao: r)),
    );
  }

  Future _projecaoFilter(ProjecaoFilterEvent event, emit) async {
    emit(state.loading());
    emit(state.success(ccusto: event.ccusto));
  }
}
