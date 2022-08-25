import 'package:speed_bi/app/components/drop_down_widget/domain/entities/ccusto_entity.dart';

class CCustoAdapter {
  static CCusto fromMap(dynamic map) {
    return CCusto(
      descricao: map['DESCRICAO'],
      ccusto: map['ID'],
    );
  }
}
