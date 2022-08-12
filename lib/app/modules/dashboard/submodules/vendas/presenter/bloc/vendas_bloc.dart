import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_usecase.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/vendas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/vendas_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VendasBloc extends Bloc<VendasEvents, VendasStates> {
  final GetVendasUseCase getVendasUseCase;

  VendasBloc({required this.getVendasUseCase}) : super(VendasInitialState()) {
    on<GetVendasEvent>(_getVendas);
  }

  Future _getVendas(GetVendasEvent event, emit) async {
    final result = await getVendasUseCase();

    result.fold(
      (l) => emit(VendasErrorState(message: l.message)),
      (r) => emit(VendasSuccessState(vendas: r)),
    );
  }
}
