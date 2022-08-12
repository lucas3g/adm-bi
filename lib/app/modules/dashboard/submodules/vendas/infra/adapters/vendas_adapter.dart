import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';

class VendasAdapter {
  static Vendas fromMap(dynamic map) {
    return Vendas(
      nome: map['nome'],
      codPedido: map['codPedido'],
      valor: double.tryParse(map['valor'].toString()) ?? 0.0,
      ccusto: map['ccusto'],
    );
  }
}
