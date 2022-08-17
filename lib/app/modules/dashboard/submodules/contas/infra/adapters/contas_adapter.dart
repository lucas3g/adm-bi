import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';

class ContasAdapter {
  static Contas fromMap(dynamic map) {
    return Contas(
      ccusto: map['CCUSTO'],
      total: double.tryParse(map['TOTAL'].toString()) ?? 0.00,
      tipo: map['TIPO'],
    );
  }
}
