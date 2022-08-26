// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adm_bi/app/core_module/constants/constants.dart';
import 'package:adm_bi/app/core_module/services/client_http/client_http_interface.dart';
import 'package:adm_bi/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/domain/exceptions/cr_exception.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/infra/datasources/cr_datasource.dart';
import 'package:adm_bi/app/utils/constants.dart';

class CRDataSource implements ICRDataSource {
  final IClientHttp clientHttp;
  final ILocalStorage localStorage;

  CRDataSource({
    required this.clientHttp,
    required this.localStorage,
  });

  @override
  Future<List> getResumoCR() async {
    final cnpj = localStorage.getData('CNPJ');

    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpj/${Constants.urlCR}');

    if (result.statusCode != 200) {
      throw const CRException(
          message: 'Erro ao buscar Resumo do Contas a Receber');
    }

    return jsonDecode(result.data);
  }
}
