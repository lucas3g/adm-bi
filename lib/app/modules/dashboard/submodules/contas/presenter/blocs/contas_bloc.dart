// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/domain/usecases/get_contas_saldo_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/events/contas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/states/contas_states.dart';

class ContasBloc extends Bloc<ContasEvents, ContasStates> {
  final GetSaldoContasUseCase getSaldoContasUseCase;

  ContasBloc({
    required this.getSaldoContasUseCase,
  }) : super(ContasInitialState()) {
    on(_getSaldoContas);
  }

  Future _getSaldoContas(GetContasEvent event, emit) async {
    final result = await getSaldoContasUseCase();

    result.fold(
      (l) => emit(ContasErrorState(message: l.message)),
      (r) => emit(ContasSuccessState(contas: r)),
    );
  }
}
