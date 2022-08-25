import 'package:speed_bi/app/modules/dashboard/submodules/estoque/domain/entities/estoque_entity.dart';

class EstoqueAdapter {
  static Estoque fromMap(dynamic map) {
    return Estoque(
      ccusto: map['CCUSTO'],
      descricao: map['DESCRICAO'],
      estoque: double.tryParse(map['EST_ATUAL'].toString()) ?? 0.00,
    );
  }
}
