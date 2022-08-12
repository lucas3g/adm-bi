import 'package:app_demonstrativo/app/core_module/types/either.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/vendas_entity.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/repositories/vendas_repository.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/usecases/get_vendas_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class IVendasRepositoryMock extends Mock implements IVendasRepository {}

void main() {
  late IVendasRepository vendasRepository;
  late GetVendasUseCase getVendasUseCase;

  setUp(() {
    vendasRepository = IVendasRepositoryMock();
    getVendasUseCase = GetVendasUseCase(repository: vendasRepository);
  });

  test('deve retornar uma lista de vendas', () async {
    when(
      () => vendasRepository.getVendas(),
    ).thenAnswer((_) async => right(<Vendas>[]));

    final result = await getVendasUseCase();

    expect(result.fold(id, id), isA<List<Vendas>>());
  });
}
