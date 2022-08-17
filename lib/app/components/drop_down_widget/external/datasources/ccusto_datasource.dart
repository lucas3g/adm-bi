import 'dart:convert';

import 'package:app_demonstrativo/app/components/drop_down_widget/domain/exception/ccusto_exception.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/infra/datasources/ccusto_datasource.dart';
import 'package:app_demonstrativo/app/core_module/constants/constants.dart';
import 'package:app_demonstrativo/app/core_module/services/client_http/client_http_interface.dart';
import 'package:app_demonstrativo/app/core_module/services/shared_preferences/local_storage_interface.dart';

class CCustoDataSource implements ICCustoDataSource {
  final IClientHttp clientHttp;
  final ILocalStorage localStorage;

  CCustoDataSource({
    required this.clientHttp,
    required this.localStorage,
  });

  @override
  Future<List> getCCustos() async {
    final cnpj = localStorage.getData('CNPJ');

    final result = await clientHttp.get('$baseUrl/getJson/$cnpj/locais/locais');

    if (result.statusCode != 200) {
      throw const CCustoException(message: 'erro ao buscar centro de custo');
    }

    return jsonDecode(result.data);
  }
}
