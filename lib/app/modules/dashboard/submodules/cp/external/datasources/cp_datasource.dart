// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_demonstrativo/app/core_module/constants/constants.dart';
import 'package:app_demonstrativo/app/core_module/services/client_http/client_http_interface.dart';
import 'package:app_demonstrativo/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/domain/exceptions/cp_exception.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/infra/datasources/cp_datasource.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';

class CPDataSource implements ICPDataSource {
  final IClientHttp clientHttp;
  final ILocalStorage localStorage;

  CPDataSource({
    required this.clientHttp,
    required this.localStorage,
  });

  @override
  Future<List> getResumoCP() async {
    final cnpj = localStorage.getData('CNPJ');

    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpj/${Constants.urlCP}');

    if (result.statusCode != 200) {
      throw const CPException(
          message: 'Erro ao buscar Resumo do Contas a Receber');
    }

    return jsonDecode(result.data);
  }
}
