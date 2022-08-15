import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';

class VendasAdapter {
  static Vendas fromMap(dynamic map) {
    return Vendas(
      nome: map['NOME'],
      codPedido: map['ID'],
      valor: double.tryParse(map['VALOR'].toString()) ?? 0.0,
      ccusto: map['CCUSTO'],
    );
  }
}
