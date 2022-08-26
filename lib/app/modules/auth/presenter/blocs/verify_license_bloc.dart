import 'package:adm_bi/app/modules/auth/domain/usecases/verify_license_usecase.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/events/verify_license_events.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/states/verify_license_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyLicenseBloc extends Bloc<VerifyLicenseEvents, VerifyLicenseStates> {
  final VerifyLicenseUseCase verifyLicenseUseCase;

  VerifyLicenseBloc({
    required this.verifyLicenseUseCase,
  }) : super(VerifyLicenseInitialState()) {
    on<VerifyLicenseEvent>(_verifyLicense);
  }

  Future<void> _verifyLicense(VerifyLicenseEvent event, emit) async {
    emit(VerifyLicenseLoadingState());
    final result = await verifyLicenseUseCase(event.id.trim());

    result
        .fold((error) => emit(VerifyLicenseErrorState(message: error.message)),
            (success) {
      if (success.ATIVO == 'S') {
        return emit(VerifyLicenseActiveState());
      }

      if (success.ATIVO == 'N') {
        return emit(VerifyLicenseNotActiveState());
      }

      return emit(VerifyLicenseNotFoundState());
    });
  }
}
