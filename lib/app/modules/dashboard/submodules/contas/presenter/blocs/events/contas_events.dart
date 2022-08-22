// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ContasEvents {}

class GetContasEvent extends ContasEvents {}

class ContasFilterEvent extends ContasEvents {
  final int ccusto;
  final String diaSemanaMes;

  ContasFilterEvent({
    required this.ccusto,
    required this.diaSemanaMes,
  });
}
