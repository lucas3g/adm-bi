import 'package:speed_bi/app/core_module/services/client_http/client_http_interface.dart';
import 'package:speed_bi/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/external/datasources/vendas_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class IClientHttpMock extends Mock implements IClientHttp {}

class ILocalStorageMock extends Mock implements ILocalStorage {}

void main() {
  late IClientHttp clientHttp;
  late ILocalStorage localStorage;
  late VendasDataSource dataSource;

  setUp(() {
    clientHttp = IClientHttpMock();
    localStorage = ILocalStorageMock();
    dataSource = VendasDataSource(
      clientHttp: clientHttp,
      localStorage: localStorage,
    );
  });

  test('deve retornar uma list dinamica da API', () async {
    when(
      () => clientHttp.get(''),
    ).thenAnswer(
      (_) async => BaseResponse(
        json,
        BaseRequest(
          method: 'GET',
          url: '',
        ),
      ),
    );

    final response = await dataSource.getVendas();

    expect(response, isA<List>());
  });
}

const json = '''
  [
  {
    'nome': 'Lucas',
    'codPedido': 1,
    'valor': 5.950,
    'ccusto': 101,
  }
]
''';
