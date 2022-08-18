// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class EstoqueEvents {}

class GetEstoqueMinimoEvent extends EstoqueEvents {}

class EstoqueFilterEvent extends EstoqueEvents {
  final int ccusto;
  final String filtro;

  EstoqueFilterEvent({
    required this.ccusto,
    required this.filtro,
  });
}
