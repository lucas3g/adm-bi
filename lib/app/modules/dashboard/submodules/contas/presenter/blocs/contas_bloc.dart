// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:speed_bi/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:speed_bi/app/modules/dashboard/submodules/contas/domain/usecases/get_contas_saldo_usecase.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/contas/presenter/blocs/events/contas_events.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/contas/presenter/blocs/states/contas_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContasBloc extends Bloc<ContasEvents, ContasStates> {
  final GetSaldoContasUseCase getSaldoContasUseCase;

  ContasBloc({
    required this.getSaldoContasUseCase,
  }) : super(ContasInitialState()) {
    on<GetContasEvent>(_getSaldoContas);
    on<ContasFilterEvent>(_contasFilter);
  }

  Future _getSaldoContas(GetContasEvent event, emit) async {
    emit(state.loading());
    final result = await getSaldoContasUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) {
        _contasFilter(
          ContasFilterEvent(
            ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa,
            diaSemanaMes: 'Dia',
          ),
          emit,
        );
        return emit(state.success(contas: r));
      },
    );
  }

  Future _contasFilter(ContasFilterEvent event, emit) async {
    emit(
      state.success(
        ccusto: event.ccusto,
        diaSemanaMes: event.diaSemanaMes,
      ),
    );
  }
}
