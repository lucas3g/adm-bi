abstract class VerifyLicenseEvents {}

class VerifyLicenseEvent extends VerifyLicenseEvents {
  final String id;

  VerifyLicenseEvent({
    required this.id,
  });
}
