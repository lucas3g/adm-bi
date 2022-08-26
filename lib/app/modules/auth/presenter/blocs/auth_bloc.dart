// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:adm_bi/app/modules/auth/domain/usecases/signin_login_usecase.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/events/auth_events.dart';
import 'package:adm_bi/app/modules/auth/presenter/blocs/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final SignInLoginUseCase signInLoginUseCase;

  AuthBloc({
    required this.signInLoginUseCase,
  }) : super(AuthInitialState()) {
    on<AuthSignInEvent>(_signIn);
  }

  Future _signIn(AuthSignInEvent event, emit) async {
    emit(state.loading());
    final result = await signInLoginUseCase(user: event.user);

    result.fold(
      (l) => emit(state.error(l.message)),
      (r) => emit(state.success(permitido: r)),
    );
  }
}
