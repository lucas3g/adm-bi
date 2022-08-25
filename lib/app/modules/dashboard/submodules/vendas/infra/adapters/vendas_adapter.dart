import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';

class VendasAdapter {
  static Vendas fromMap(dynamic map) {
    return Vendas(
      ccusto: map['CCUSTO'],
      data: DateTime.parse(map['DATA']),
      total: double.tryParse(map['TOTAL'].toString()) ?? 0.0,
    );
  }
}
