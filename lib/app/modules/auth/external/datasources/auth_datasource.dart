// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:speed_bi/app/core_module/constants/constants.dart';
import 'package:speed_bi/app/core_module/services/client_http/client_http_interface.dart';
import 'package:speed_bi/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:speed_bi/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthDataSource implements IAuthDataSource {
  final IClientHttp clientHttp;

  AuthDataSource({
    required this.clientHttp,
  });

  @override
  Future<bool> login({required Map<String, dynamic> map}) async {
    final data = {
      'USUARIO': map['LOGIN'],
      'SENHA': map['SENHA'],
    };

    final cnpj = map['CNPJ'].toString().replaceAll('.', '').substring(0, 8);

    final result = await clientHttp.post('$baseUrl/login/$cnpj', data: data);

    await Future.delayed(const Duration(seconds: 1));

    if (result.statusCode != 200) {
      throw const AuthException(message: 'Erro ao tentar fazer login.');
    }

    if (result.data.toString().trim() == '[]') {
      throw const AuthException(message: 'Usuário ou senha incorreta.');
    }

    if (jsonDecode(result.data)['APP_DASH'] == 'N') {
      throw const AuthException(message: 'Usuário sem permissão para acessar.');
    }

    return true;
  }

  @override
  Future<Map<String, dynamic>> verifyLicense(String id) async {
    clientHttp.setHeaders({'cnpj': 'licenca', 'id': id});

    final response = await clientHttp.get('$baseUrlLicense/licenca');

    await Future.delayed(const Duration(milliseconds: 600));

    if (response.statusCode != 200) {
      throw AuthException(
        message: 'Error ao tentar verificar licença',
        stackTrace: StackTrace.current,
      );
    }

    clientHttp.setHeaders({'Content-Type': 'application/json'});

    return response.data;
  }
}
