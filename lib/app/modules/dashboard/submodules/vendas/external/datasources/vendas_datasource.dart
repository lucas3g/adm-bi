import 'dart:convert';

import 'package:app_demonstrativo/app/core_module/constants/constants.dart';
import 'package:app_demonstrativo/app/core_module/services/client_http/client_http_interface.dart';
import 'package:app_demonstrativo/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/exceptions/vendas_exception.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/datasources/vendas_datasource.dart';

class VendasDataSource implements IVendasDataSource {
  final IClientHttp clientHttp;
  final ILocalStorage localStorage;

  VendasDataSource({required this.clientHttp, required this.localStorage});

  @override
  Future<List> getVendas() async {
    final cnpj = localStorage.getData('CNPJ');

    final response =
        await clientHttp.get('$baseUrl/getJson/$cnpj/vendas/vendas');

    if (response.statusCode != 200) {
      throw const VendasException(message: 'Erro ao buscar vendas na API');
    }

    return jsonDecode(response.data);
  }

  @override
  Future<List> getVendasGrafico() async {
    final cnpj = localStorage.getData('CNPJ');

    final response =
        await clientHttp.get('$baseUrl/getJson/$cnpj/vendas/grafico');

    if (response.statusCode != 200) {
      throw const VendasException(
          message: 'Erro ao buscar vendas para o grafico na API');
    }

    return jsonDecode(response.data);
  }

  @override
  Future<List> getProjecao() async {
    final cnpj = localStorage.getData('CNPJ');

    final response =
        await clientHttp.get('$baseUrl/getJson/$cnpj/vendas/projecao');

    if (response.statusCode != 200) {
      throw const VendasException(message: 'Erro ao buscar projeção na API');
    }

    return jsonDecode(response.data);
  }
}
