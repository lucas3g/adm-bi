import 'package:adm_bi/app/modules/auth/domain/usecases/get_infos_device_usecase.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/events/info_device_events.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/states/info_device_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoDeviceBloc extends Bloc<InfoDeviceEvents, InfoDeviceStates> {
  final GetInfosDeviceUseCase getInfosDeviceUseCase;

  InfoDeviceBloc({
    required this.getInfosDeviceUseCase,
  }) : super(InfoDeviceInitialState()) {
    on<GetInfoDeviceEvent>(_getInfoDevice);
  }

  Future<void> _getInfoDevice(GetInfoDeviceEvent event, emit) async {
    emit(InfoDeviceLoadingState());
    final result = await getInfosDeviceUseCase();
    result.fold(
      (error) {
        emit(InfoDeviceErrorState(message: error.message));
      },
      (success) {
        emit(InfoDeviceSuccessState(infoDeviceEntity: success));
      },
    );
  }
}
