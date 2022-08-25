import 'package:speed_bi/app/modules/dashboard/submodules/vendas/domain/entities/projecao_vendas.dart';

class ProjecaoAdapter {
  static ProjecaoVendas fromMap(dynamic map) {
    return ProjecaoVendas(
      ccusto: map['CCUSTO'],
      totalDiario: double.tryParse(map['TOTAL_DIARIO'].toString()) ?? 0.00,
      totalMes: double.tryParse(map['TOTAL_MES'].toString()) ?? 0.00,
      lucro: double.tryParse(map['LUCRO'].toString()) ?? 0.00,
    );
  }
}
