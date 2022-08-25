// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:speed_bi/app/core_module/constants/constants.dart';
import 'package:speed_bi/app/core_module/services/client_http/client_http_interface.dart';
import 'package:speed_bi/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/contas/domain/exceptions/contas_exception.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/contas/infra/datasources/contas_datasource.dart';
import 'package:speed_bi/app/utils/constants.dart';

class ContasDataSource implements IContasDataSource {
  final IClientHttp clientHttp;
  final ILocalStorage localStorage;

  ContasDataSource({
    required this.clientHttp,
    required this.localStorage,
  });

  @override
  Future<List> getContas() async {
    final cnpj = localStorage.getData('CNPJ');

    final result = await clientHttp
        .get('$baseUrl/getJson/$cnpj/${Constants.urlMovimento}');

    if (result.statusCode != 200) {
      throw const ContasException(message: 'Erro ao buscar saldo das contas');
    }

    return jsonDecode(result.data);
  }
}
