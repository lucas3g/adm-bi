// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adm_bi/app/core_module/constants/constants.dart';
import 'package:adm_bi/app/core_module/services/client_http/client_http_interface.dart';
import 'package:adm_bi/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/resumo_formas/domain/exceptions/formas_pag_exception.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/resumo_formas/infra/datasources/formas_pag_datasource.dart';
import 'package:adm_bi/app/utils/constants.dart';

class FormasPagDatSource implements IFormasPagDataSource {
  final IClientHttp clientHttp;
  final ILocalStorage localStorage;

  FormasPagDatSource({
    required this.clientHttp,
    required this.localStorage,
  });

  @override
  Future<List> getResumoFormasPag() async {
    final cnpj = localStorage.getData('CNPJ');

    final result =
        await clientHttp.get('$baseUrl/getJson/$cnpj/${Constants.urlResumoFP}');

    if (result.statusCode != 200) {
      throw const FormasPagException(
          message: 'Erro ao buscar resumo das formas de pagamento');
    }

    return jsonDecode(result.data);
  }
}
