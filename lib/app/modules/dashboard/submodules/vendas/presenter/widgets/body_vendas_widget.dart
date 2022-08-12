import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BodyVendasWidget extends StatefulWidget {
  const BodyVendasWidget({Key? key}) : super(key: key);

  @override
  State<BodyVendasWidget> createState() => _BodyVendasWidgetState();
}

class _BodyVendasWidgetState extends State<BodyVendasWidget> {
  late List<VendasSemanais> listaNova = [];

  montaGrafico() {
    listaNova = [
      VendasSemanais(
        DateTime.now(),
        5654.90,
      ),
      VendasSemanais(
        DateTime.now().add(const Duration(days: 1)),
        3423.60,
      ),
      VendasSemanais(
        DateTime.now().add(const Duration(days: 2)),
        1020.90,
      ),
      VendasSemanais(
        DateTime.now().add(const Duration(days: 3)),
        6712.90,
      ),
      VendasSemanais(
        DateTime.now().add(const Duration(days: 4)),
        7642.90,
      ),
      VendasSemanais(
        DateTime.now().add(const Duration(days: 5)),
        3256.90,
      ),
      VendasSemanais(
        DateTime.now().add(const Duration(days: 7)),
        3412.90,
      ),
    ];
    listaNova.sort((a, b) => a.dia.isAfter(b.dia) ? 1 : -1);
    return listaNova;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * .37,
      child: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(
          enable: true,
          color: Colors.white,
          textStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          shadowColor: AppTheme.colors.primary,
        ),
        onTooltipRender: (TooltipArgs args) {
          final DateTime data = listaNova[args.pointIndex as int].dia;
          final double valor = listaNova[args.pointIndex as int].valor;
          args.header = 'Dia - ${data.DiaMes()}';
          args.text = valor.reais();
        },
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          numberFormat: NumberFormat.simpleCurrency(locale: 'pt-br'),
        ),
        series: <CartesianSeries<VendasSemanais, String>>[
          AreaSeries<VendasSemanais, String>(
            color: AppTheme.colors.primary,
            dataSource: montaGrafico(),
            xValueMapper: (VendasSemanais vendas, _) => vendas.dia.Dia(),
            yValueMapper: (VendasSemanais vendas, _) => vendas.valor,
            markerSettings: const MarkerSettings(
                isVisible: true, shape: DataMarkerType.circle),
          )
        ],
        title: ChartTitle(
          text: 'Vendas dos Últimos 7 dias',
          textStyle: AppTheme.textStyles.titleGraficoVendas,
        ),
      ),
    );
  }
}

class VendasSemanais {
  VendasSemanais(this.dia, this.valor);
  final DateTime dia;
  final double valor;
}
