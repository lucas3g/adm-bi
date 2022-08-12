import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/grafico_vendas.dart';

class VendasGraficoAdapter {
  static GraficoVendas fromMap(dynamic map) {
    return GraficoVendas(
      ccusto: map['ccusto'],
      data: map['data'],
      total: double.tryParse(map['total']) ?? 0.00,
    );
  }
}
