abstract class VendasEvents {}

class GetVendasEvent extends VendasEvents {}

class VendasFilterEvent extends VendasEvents {
  final int ccusto;

  VendasFilterEvent({required this.ccusto});
}
