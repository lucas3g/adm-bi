import 'package:adm_bi/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_usecase.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/events/vendas_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/states/vendas_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class VendasBloc extends Bloc<VendasEvents, VendasStates> {
  final GetVendasUseCase getVendasUseCase;

  VendasBloc({
    required this.getVendasUseCase,
  }) : super(VendasInitialState()) {
    on<GetVendasEvent>(_getVendas);
    on<VendasFilterEvent>(_vendasFilter);
  }

  Future _getVendas(GetVendasEvent event, emit) async {
    emit(state.loading());
    final result = await getVendasUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) {
        _vendasFilter(
          VendasFilterEvent(
              ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa),
          emit,
        );
        return emit(state.success(vendas: r));
      },
    );
  }

  Future _vendasFilter(VendasFilterEvent event, emit) async {
    emit(state.success(ccusto: event.ccusto));
  }
}
