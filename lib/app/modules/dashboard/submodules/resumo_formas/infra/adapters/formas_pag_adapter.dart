import 'package:speed_bi/app/modules/dashboard/submodules/resumo_formas/domain/entities/formas_pag_entity.dart';

class FormasPagAdapter {
  static FormasPag fromMap(dynamic map) {
    return FormasPag(
      ccusto: map['LOCAL'],
      formaPag: map['FORMA_PAG'],
      descricao: map['DESC_FORMA'],
      tipo: map['TIPO'],
      totalForma: double.tryParse(map['TOTAL_FORMA'].toString()) ?? 0.00,
      totalGeral: double.tryParse(map['TOTAL_GERAL'].toString()) ?? 0.00,
      percentual: double.tryParse(map['PERCENTUAL'].toString()) ?? 0.00,
    );
  }
}
