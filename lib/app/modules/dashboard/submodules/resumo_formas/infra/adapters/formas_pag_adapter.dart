import 'package:adm_bi/app/modules/dashboard/submodules/resumo_formas/domain/entities/formas_pag_entity.dart';

class FormasPagAdapter {
  static FormasPag fromMap(dynamic map) {
    return FormasPag(
      ccusto: map['CCUSTO'],
      formaPag: map['FORMA_PAG'],
      descricao: map['DESC_FORMA'],
      tipo: map['TIPO'],
      totalForma: double.tryParse(map['TOTAL_FORMA'].toString()) ?? 0.00,
    );
  }
}
