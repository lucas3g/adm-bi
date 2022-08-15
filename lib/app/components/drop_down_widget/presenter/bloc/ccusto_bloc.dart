import 'package:app_demonstrativo/app/components/drop_down_widget/domain/usecases/get_ccustos_usecase.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/events/ccusto_event.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CCustoBloc extends Bloc<CCustoEvents, CCustoStates> {
  final GetCCustoUseCase getCCustoUseCase;

  CCustoBloc({required this.getCCustoUseCase})
      : super(CCustoInitialState(selectedEmpresa: 0)) {
    on<GetCCustoEvent>(_getCCustos);
    on(_changeCCusto);
  }

  Future _getCCustos(GetCCustoEvent event, emit) async {
    emit(CCustoLoadingState(selectedEmpresa: 0));
    final result = await getCCustoUseCase();

    result.fold(
      (l) => emit(CCustoErrorState(message: l.message, selectedEmpresa: 0)),
      (r) => emit(CCustoSuccessState(
        ccustos: r,
        initialValue: r[0].ccusto,
        selectedEmpresa: r[0].ccusto,
      )),
    );
  }

  void _changeCCusto(ChangeCCustoEvent event, emit) {
    emit(CCustoSuccessState(
      ccustos: (state as CCustoSuccessState).ccustos,
      initialValue: event.ccusto,
      selectedEmpresa: event.ccusto,
    ));
  }
}
