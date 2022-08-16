import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/domain/entities/cr_entity.dart';

class CRAdapter {
  static CR fromMap(dynamic map) {
    return CR(
      ccusto: map['CCUSTO'],
      nome: map['NOME'],
      valor: double.tryParse(map['TOTAL'].toString()) ?? 0.00,
    );
  }
}
