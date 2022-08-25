import 'package:speed_bi/app/components/drop_down_widget/domain/usecases/get_ccustos_usecase.dart';
import 'package:speed_bi/app/components/drop_down_widget/presenter/bloc/events/ccusto_event.dart';
import 'package:speed_bi/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CCustoBloc extends Bloc<CCustoEvents, CCustoStates> {
  final GetCCustoUseCase getCCustoUseCase;

  CCustoBloc({required this.getCCustoUseCase}) : super(CCustoInitialState()) {
    on<GetCCustoEvent>(_getCCustos);
    on<ChangeCCustoEvent>(_changeCCusto);
  }

  Future _getCCustos(GetCCustoEvent event, emit) async {
    emit(state.loading());
    final result = await getCCustoUseCase();

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) => emit(CCustoSuccessState(
        ccustos: r,
        selectedEmpresa: r[0].ccusto,
      )),
    );
  }

  void _changeCCusto(ChangeCCustoEvent event, emit) {
    emit(state.success(selectedEmpresa: event.ccusto));
  }
}
