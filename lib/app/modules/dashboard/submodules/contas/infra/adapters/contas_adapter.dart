import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';

class ContasAdapter {
  static Contas fromMap(dynamic map) {
    return Contas(
      ccusto: map['ccusto'],
      total: map['total'],
      tipo: map['tipo'],
    );
  }
}
