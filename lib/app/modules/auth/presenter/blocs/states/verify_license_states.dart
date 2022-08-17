abstract class VerifyLicenseStates {}

class VerifyLicenseInitialState extends VerifyLicenseStates {}

class VerifyLicenseLoadingState extends VerifyLicenseStates {}

class VerifyLicenseActiveState extends VerifyLicenseStates {}

class VerifyLicenseNotActiveState extends VerifyLicenseStates {}

class VerifyLicenseNotFoundState extends VerifyLicenseStates {}

class VerifyLicenseErrorState extends VerifyLicenseStates {
  final String message;

  VerifyLicenseErrorState({
    required this.message,
  });
}
