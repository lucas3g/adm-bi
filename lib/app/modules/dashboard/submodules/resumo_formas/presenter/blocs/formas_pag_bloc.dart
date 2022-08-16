// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/domain/usecases/get_resumo_formas_pag_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/events/formas_pag_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/states/formas_pag_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormasPagBloc extends Bloc<FormasPagEvents, FormasPagStates> {
  final GetResumoFormasPagUseCase getResumoFormasPagUseCase;

  FormasPagBloc({
    required this.getResumoFormasPagUseCase,
  }) : super(FormasPagInitialState()) {
    on<GetFormasPagEvent>(_getResumoFP);
    on<FilterFormasPag>(_formasFilter);
  }

  Future _getResumoFP(GetFormasPagEvent event, emit) async {
    emit(state.loading());
    final result = await getResumoFormasPagUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) {
        _formasFilter(
          FilterFormasPag(
              ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa),
          emit,
        );
        return emit(state.success(formasPag: r));
      },
    );
  }

  Future _formasFilter(FilterFormasPag event, emit) async {
    emit(state.success(ccusto: event.ccusto));
  }
}
