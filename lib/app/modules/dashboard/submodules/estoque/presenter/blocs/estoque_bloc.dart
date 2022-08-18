// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/usecases/get_estoque_minimo_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/presenter/blocs/events/estoque_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/presenter/blocs/states/estoque_states.dart';

class EstoqueBloc extends Bloc<EstoqueEvents, EstoqueStates> {
  final GetEstoqueMinimoUseCase getEstoqueMinimoUseCase;

  EstoqueBloc({
    required this.getEstoqueMinimoUseCase,
  }) : super(EstoqueInitialState()) {
    on<GetEstoqueMinimoEvent>(_getEstoqueMinimo);
    on<EstoqueFilterEvent>(_estoqueFilter);
  }

  Future _getEstoqueMinimo(GetEstoqueMinimoEvent event, emit) async {
    final result = await getEstoqueMinimoUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) {
        return emit(state.success(estoques: r));
      },
    );
  }

  Future _estoqueFilter(EstoqueFilterEvent event, emit) async {
    emit(state.filtered(ccusto: event.ccusto, filtro: event.filtro));
  }
}
