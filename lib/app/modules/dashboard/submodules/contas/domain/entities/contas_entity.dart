// ignore_for_file: public_member_api_docs, sort_constructors_first

class Contas {
  final int ccusto;
  final double totalDiario;
  final double totalSemanal;
  final double totalMes;
  final String cardSubtitle;
  final String dc;
  final int cardColor;

  Contas({
    required this.ccusto,
    required this.totalDiario,
    required this.totalSemanal,
    required this.totalMes,
    required this.cardSubtitle,
    required this.dc,
    required this.cardColor,
  });

  @override
  String toString() {
    return 'Contas(ccusto: $ccusto, totalDiario: $totalDiario, totalSemanal: $totalSemanal, totalMes: $totalMes, cardSubtitle: $cardSubtitle, dc: $dc, cardColor: $cardColor)';
  }
}
