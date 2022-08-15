import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/grafico_vendas.dart';

class VendasGraficoAdapter {
  static GraficoVendas fromMap(dynamic map) {
    return GraficoVendas(
      ccusto: map['CCUSTO'],
      data: DateTime.parse(map['DATA']),
      total: double.tryParse(map['TOTAL'].toString()) ?? 0.00,
    );
  }
}
