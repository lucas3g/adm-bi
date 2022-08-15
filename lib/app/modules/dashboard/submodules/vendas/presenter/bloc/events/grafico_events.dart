abstract class GraficoEvents {}

class GetGraficoEvent extends GraficoEvents {}

class GraficoFilterEvent extends GraficoEvents {
  final int ccusto;

  GraficoFilterEvent({required this.ccusto});
}
