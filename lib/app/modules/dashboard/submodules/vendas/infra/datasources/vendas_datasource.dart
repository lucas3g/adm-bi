abstract class IVendasDataSource {
  Future<List> getVendas();
  Future<List> getVendasGrafico();
  Future<List> getProjecao();
}
