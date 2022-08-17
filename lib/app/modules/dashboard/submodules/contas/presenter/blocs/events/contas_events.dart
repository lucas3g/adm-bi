abstract class ContasEvents {}

class GetContasEvent extends ContasEvents {}

class ContasFilterEvent extends ContasEvents {
  final int ccusto;

  ContasFilterEvent({required this.ccusto});
}
