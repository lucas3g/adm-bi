import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/datasources/vendas_datasource.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/infra/repositories/vendas_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class IVendasDataSourceMock extends Mock implements IVendasDataSource {}

void main() {
  late IVendasDataSource dataSource;
  late VendasRepository repository;

  setUp(() {
    dataSource = IVendasDataSourceMock();
    repository = VendasRepository(
      dataSourceVendas: dataSource,
      dataSourceGrafico: dataSource,
    );
  });

  test('deve retornar uma lista de vendas', () async {
    when(
      () => dataSource.getVendas(),
    ).thenAnswer((_) async => listMap);

    final result = await repository.getVendas();

    expect(result.fold(id, id), isA<List<Vendas>>());
  });
}

final listMap = [
  {
    'nome': 'Lucas',
    'codPedido': 1,
    'valor': 5.950,
    'ccusto': 101,
  }
];
