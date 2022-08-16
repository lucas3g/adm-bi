abstract class CPEvents {}

class GetCPEvent extends CPEvents {}

class CPFilterEvent extends CPEvents {
  final int ccusto;
  final String filtro;

  CPFilterEvent({
    required this.ccusto,
    required this.filtro,
  });
}
