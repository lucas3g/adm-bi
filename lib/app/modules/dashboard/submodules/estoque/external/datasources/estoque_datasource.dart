// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_demonstrativo/app/core_module/constants/constants.dart';
import 'package:app_demonstrativo/app/core_module/services/client_http/client_http_interface.dart';
import 'package:app_demonstrativo/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/domain/exceptions/estoque_exceptions.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/infra/datasources/estoque_datasource.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';

class EstoqueDataSource implements IEstoqueDataSource {
  final IClientHttp clientHttp;
  final ILocalStorage localStorage;

  EstoqueDataSource({
    required this.clientHttp,
    required this.localStorage,
  });

  @override
  Future<List> getEstoqueMinimo() async {
    final cnpj = localStorage.getData('CNPJ');

    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpj/${Constants.urlEstoque}');

    if (result.statusCode != 200) {
      throw const EstoqueException(message: 'Erro ao buscar estoque');
    }

    return jsonDecode(result.data);
  }
}
