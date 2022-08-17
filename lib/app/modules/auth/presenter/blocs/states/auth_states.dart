abstract class AuthStates {
  final bool permitido;

  AuthStates({required this.permitido});

  AuthSuccessState success({bool? permitido}) {
    return AuthSuccessState(
      permitido: permitido ?? this.permitido,
    );
  }

  AuthLoadingState loading() {
    return AuthLoadingState(
      permitido: permitido,
    );
  }

  AuthErrorState error(String message) {
    return AuthErrorState(
      message: message,
      permitido: permitido,
    );
  }
}

class AuthInitialState extends AuthStates {
  AuthInitialState() : super(permitido: false);
}

class AuthLoadingState extends AuthStates {
  AuthLoadingState({
    required super.permitido,
  });
}

class AuthSuccessState extends AuthStates {
  AuthSuccessState({
    required super.permitido,
  });
}

class AuthErrorState extends AuthStates {
  final String message;

  AuthErrorState({
    required this.message,
    required super.permitido,
  });
}
