import 'package:app_demonstrativo/app/components/drop_down_widget/domain/entities/ccusto_entity.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/domain/exception/ccusto_exception.dart';
import 'package:app_demonstrativo/app/core_module/types/either.dart';

abstract class ICCustoRepository {
  Future<Either<ICCustoException, List<CCusto>>> getCCustos();
}
