import 'package:adm_bi/app/modules/dashboard/submodules/contas/domain/entities/contas_entity.dart';

class ContasAdapter {
  static Contas fromMap(dynamic map) {
    return Contas(
      ccusto: map['CCUSTO'],
      totalDiario: double.tryParse(map['TOTAL_DIA'].toString()) ?? 0.00,
      totalSemanal: double.tryParse(map['TOTAL_SEMANA'].toString()) ?? 0.00,
      totalMes: double.tryParse(map['TOTAL_MES'].toString()) ?? 0.00,
      cardSubtitle: map['CARD_SUBTITLE'],
      dc: map['DC'],
      cardColor:
          int.tryParse(map['CARD_COR'].toString()) ?? 0xff66a61e, // VERDE
    );
  }
}
