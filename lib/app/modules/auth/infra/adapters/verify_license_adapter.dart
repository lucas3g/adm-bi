import 'package:adm_bi/app/modules/auth/domain/entities/verify_license_entity.dart';

class VerifyLicenseAdapter {
  static VerifyLicenseEntity fromMap(Map map) {
    return VerifyLicenseEntity(
      ID_DEVICE: map['ID_DEVICE'] ?? '',
      APELIDO: map['APELIDO'] ?? '',
      ATIVO: map['ATIVO'] ?? '',
      EXIBE_ABASTECIDAS: map['EXIBE_ABASTECIDAS'] ?? '',
      FORMA_PAG: map['FORMA_PAG'] ?? 0,
      OPERACAO: map['OPERACAO'] ?? 0,
    );
  }
}
