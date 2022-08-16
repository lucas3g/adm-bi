abstract class CREvents {}

class GetCREvent extends CREvents {}

class CRFilterEvent extends CREvents {
  final int ccusto;
  final String filtro;

  CRFilterEvent({
    required this.ccusto,
    required this.filtro,
  });
}
