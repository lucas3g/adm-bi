import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/domain/entities/cp_entity.dart';

class CPAdapter {
  static CP fromMap(dynamic map) {
    return CP(
      ccusto: map['CCUSTO'],
      nome: map['NOME'],
      valor: double.tryParse(map['TOTAL'].toString()) ?? 0.00,
    );
  }
}
